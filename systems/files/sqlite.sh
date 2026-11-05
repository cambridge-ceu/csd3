#!/bin/bash
set -euo pipefail

V=3.54.1
MODULE="ceuadmin/sqlite/$V"
PREFIX="$CEUADMIN/sqlite/$V"

echo "=== SQLite $V verification ==="

# 1. Load module
module purge
module load "$MODULE"

echo -e "\n[1] Module"
module list
echo "SQLITE_ROOT=$SQLITE_ROOT"
[[ "$SQLITE_ROOT" == "$PREFIX" ]]

# 2. CLI
echo -e "\n[2] SQLite CLI"
command -v sqlite3
sqlite3 --version
[[ "$(sqlite3 --version | awk '{print $1}')" == "$V" ]]

# 3. pkg-config
echo -e "\n[3] pkg-config"
pkg-config --modversion sqlite3
pkg-config --variable=prefix sqlite3
pkg-config --cflags --libs sqlite3
[[ "$(pkg-config --modversion sqlite3)" == "$V" ]]

# 4. CLI dependencies
echo -e "\n[4] CLI dependencies"
ldd "$PREFIX/bin/sqlite3"

# 5. Tcl extension
echo -e "\n[5] Tcl extension"
find "$PREFIX/tcl8.6" -maxdepth 1 -type f -ls

TCL_VERSION=$(tclsh <<'EOF'
puts [package require sqlite3]
EOF
)
echo "Tcl SQLite version: $TCL_VERSION"
[[ "$TCL_VERSION" == "$V" ]]

# 6. Compile and link shared library test
echo -e "\n[6] Shared library compilation"

TESTDIR=$(mktemp -d)
trap 'rm -rf "$TESTDIR"' EXIT

cat > "$TESTDIR/test-sqlite.c" <<'EOF'
#include <stdio.h>
#include <sqlite3.h>

int main(void)
{
    printf("SQLite version: %s\n", sqlite3_libversion());
    return 0;
}
EOF

gcc -I"$PREFIX/include" \
    -L"$PREFIX/lib" \
    -Wl,-rpath,"$PREFIX/lib" \
    "$TESTDIR/test-sqlite.c" \
    -lsqlite3 \
    -o "$TESTDIR/test-sqlite"

"$TESTDIR/test-sqlite"

[[ "$("$TESTDIR/test-sqlite")" == "SQLite version: $V" ]]

# 7. Runtime library resolution
echo -e "\n[7] Dynamic library resolution"
ldd "$TESTDIR/test-sqlite" | grep libsqlite3

ldd "$TESTDIR/test-sqlite" |
    grep libsqlite3 |
    grep -F "$PREFIX/lib/"

echo -e "\n=== ALL SQLITE $V CHECKS PASSED ==="
