#!/usr/bin/env bash
# partition_check.sh
# Print partition stats and recommend the one with the smallest queue-hours
#   queue-hours = (CPU-hours still pending) / (idle CPUs right now)

set -euo pipefail

partitions=(icelake icelake-himem cclake cclake-himem sapphire)

best_queue=1e9          # start "infinite"
best_part=""

{
  printf "PARTITION\tNODES\tIDLE_N\tMIX_N\tMAINT_N\tIDLE_CPUS\tRUN_CPUS\tPEND_CPUS\tMAX_WAIT\tAVG_PEND_H\tAVG_RUN_H\tQUEUE_H\n"

  for p in "${partitions[@]}"; do
    ########################  node-level stats  ########################
    nodefile=$(mktemp)
    sinfo -N -p "$p" -h -o '%t %C' >"$nodefile"   # %t=state, %C=A/I/O/T

    idle_n=$(grep -c '^idle'  "$nodefile" || true)
    mix_n=$(grep -c '^mix'    "$nodefile" || true)
    maint_n=$(grep -c '^maint' "$nodefile" || true)
    alloc_n=$(grep -c '^alloc' "$nodefile" || true)
    total_nodes=$(( idle_n + mix_n + maint_n + alloc_n ))

    idle_cpus=0
    run_cpus=0
    while read -r state cpu_str; do
      IFS='/' read -r alloc idle other total <<<"$cpu_str"
      case "$state" in
        idle)  (( idle_cpus += idle )) ;;
        mix)   (( idle_cpus += idle )); (( run_cpus += alloc )) ;;
        alloc) (( run_cpus += alloc )) ;;
      esac
    done <"$nodefile"
    rm -f "$nodefile"

    ########################  queue-level stats  ########################
    pend_cpus=$(squeue -p "$p" -t PD -h -o '%C' |
                awk -F'/' '{sum+=$1} END{print sum+0}')

    max_wait=$(squeue -p "$p" -t PD -h -o '%V' | sort -h | tail -n1)
    [[ -z $max_wait ]] && max_wait=0

    # average requested wall-time of pending jobs (h)
    pend_h=$(squeue -p "$p" -t PD -h -o '%l' |
             awk -F':' '{s=$1*3600+$2*60+$3; sum+=s; n++}
                         END{print (n?sum/n/3600:0)}')

    # average elapsed wall-time of running jobs (h)
    run_h=$(squeue -p "$p" -t R  -h -o '%M' |
            awk -F':' '{s=$1*3600+$2*60+$3; sum+=s; n++}
                        END{print (n?sum/n/3600:0)}')

    backlog_h=$(awk -v pc="$pend_cpus" -v ph="$pend_h" 'BEGIN{print pc*ph}')
    queue_h=$(awk -v b="$backlog_h" -v i="$idle_cpus" 'BEGIN{print (i?b/i:1e9)}')

    ########################  print one row  ########################
    printf "%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%s\t%.1f\t%.1f\t%.2f\n" \
           "$p" "$total_nodes" "$idle_n" "$mix_n" "$maint_n" \
           "$idle_cpus" "$run_cpus" "$pend_cpus" "$max_wait" \
           "$pend_h" "$run_h" "$queue_h"

    ########################  track best  ########################
    if awk -v q="$queue_h" -v b="$best_queue" 'BEGIN{exit(q<b)?0:1}'; then
      best_queue="$queue_h"
      best_part="$p"
    fi
  done

  echo
  printf "=> Recommended partition: %s (queue_h ≈ %.2f h)\n" \
         "$best_part" "$best_queue"
} | column -t
