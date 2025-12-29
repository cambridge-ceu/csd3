---
sort: 29
---

# gcloud

Web: <https://cloud.google.com/sdk>

## Installation

### 550.0.0

```bash
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
tar -xzf google-cloud-cli-linux-x86_64.tar.gz
google-cloud-sdk/bin/gcloud --version
# Google Cloud SDK 550.0.0
# bq 2.1.26
# bundled-python3-unix 3.13.10
# core 2025.12.12
# gcloud-crc32c 1.0.0
# gsutil 5.35
mv google-cloud-sdk/ 550.0.0
550.0.0/install.sh
```

```
Your current Google Cloud CLI version is: 550.0.0
The latest available version is: 550.0.0

┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                    Components                                                   │
├───────────────┬──────────────────────────────────────────────────────┬──────────────────────────────┬───────────┤
│     Status    │                         Name                         │              ID              │    Size   │
├───────────────┼──────────────────────────────────────────────────────┼──────────────────────────────┼───────────┤
│ Not Installed │ App Engine Go Extensions                             │ app-engine-go                │   4.7 MiB │
│ Not Installed │ Artifact Registry Go Module Package Helper           │ package-go-module            │   < 1 MiB │
│ Not Installed │ Cloud Bigtable Command Line Tool                     │ cbt                          │  20.5 MiB │
│ Not Installed │ Cloud Bigtable Emulator                              │ bigtable                     │   8.5 MiB │
│ Not Installed │ Cloud Datastore Emulator                             │ cloud-datastore-emulator     │  36.2 MiB │
│ Not Installed │ Cloud Firestore Emulator                             │ cloud-firestore-emulator     │  54.3 MiB │
│ Not Installed │ Cloud Pub/Sub Emulator                               │ pubsub-emulator              │  49.8 MiB │
│ Not Installed │ Cloud Run Proxy                                      │ cloud-run-proxy              │  13.3 MiB │
│ Not Installed │ Cloud SQL Proxy v2                                   │ cloud-sql-proxy              │  15.5 MiB │
│ Not Installed │ Cloud Spanner Emulator                               │ cloud-spanner-emulator       │  37.7 MiB │
│ Not Installed │ Google Container Registry's Docker credential helper │ docker-credential-gcr        │   1.8 MiB │
│ Not Installed │ Kustomize                                            │ kustomize                    │   4.3 MiB │
│ Not Installed │ Log Streaming                                        │ log-streaming                │  18.2 MiB │
│ Not Installed │ Managed Flink Client                                 │ managed-flink-client         │ 383.4 MiB │
│ Not Installed │ Minikube                                             │ minikube                     │  50.5 MiB │
│ Not Installed │ Nomos CLI                                            │ nomos                        │  35.2 MiB │
│ Not Installed │ On-Demand Scanning API extraction helper             │ local-extract                │  43.9 MiB │
│ Not Installed │ Skaffold                                             │ skaffold                     │  34.3 MiB │
│ Not Installed │ Spanner Cli                                          │ spanner-cli                  │  12.9 MiB │
│ Not Installed │ Spanner migration tool                               │ spanner-migration-tool       │  29.5 MiB │
│ Not Installed │ Terraform Tools                                      │ terraform-tools              │  66.6 MiB │
│ Not Installed │ anthos-auth                                          │ anthos-auth                  │  22.0 MiB │
│ Not Installed │ config-connector                                     │ config-connector             │ 134.9 MiB │
│ Not Installed │ enterprise-certificate-proxy                         │ enterprise-certificate-proxy │  15.9 MiB │
│ Not Installed │ gcloud Alpha Commands                                │ alpha                        │   < 1 MiB │
│ Not Installed │ gcloud Beta Commands                                 │ beta                         │   < 1 MiB │
│ Not Installed │ gcloud app Java Extensions                           │ app-engine-java              │ 233.7 MiB │
│ Not Installed │ gcloud app Python Extensions                         │ app-engine-python            │   3.8 MiB │
│ Not Installed │ gcloud app Python Extensions (Extra Libraries)       │ app-engine-python-extras     │   < 1 MiB │
│ Not Installed │ gke-gcloud-auth-plugin                               │ gke-gcloud-auth-plugin       │   3.5 MiB │
│ Not Installed │ istioctl                                             │ istioctl                     │  27.1 MiB │
│ Not Installed │ kpt                                                  │ kpt                          │  15.3 MiB │
│ Not Installed │ kubectl                                              │ kubectl                      │   < 1 MiB │
│ Not Installed │ kubectl-oidc                                         │ kubectl-oidc                 │  22.0 MiB │
│ Not Installed │ pkg                                                  │ pkg                          │           │
│ Installed     │ BigQuery Command Line Tool                           │ bq                           │   1.8 MiB │
│ Installed     │ Bundled Python 3.13                                  │ bundled-python3-unix         │ 138.6 MiB │
│ Installed     │ Cloud Storage Command Line Tool                      │ gsutil                       │  12.4 MiB │
│ Installed     │ Google Cloud CLI Core Libraries                      │ core                         │  23.5 MiB │
│ Installed     │ Google Cloud CRC32C Hash Tool                        │ gcloud-crc32c                │   1.5 MiB │
└───────────────┴──────────────────────────────────────────────────────┴──────────────────────────────┴───────────┘
To install or remove components at your current Google Cloud CLI version [550.0.0], run:
  $ gcloud components install COMPONENT_ID
  $ gcloud components remove COMPONENT_ID

To update your Google Cloud CLI installation to the latest version [550.0.0], run:
  $ gcloud components update


Modify profile to update your $PATH and enable shell command completion?

Do you want to continue (Y/n)?  Y

The Google Cloud SDK installer will now prompt you to update an rc file to bring the Google Cloud CLIs into your environment.

Enter a path to an rc file to update, or leave blank to use [/home/jhz22/.bashrc]:
Backing up [/home/jhz22/.bashrc] to [/home/jhz22/.bashrc.backup].
[/home/jhz22/.bashrc] has been updated.

==> Start a new shell for the changes to take effect.


For more information on how to get started, please visit:
  https://cloud.google.com/sdk/docs/quickstarts
```

## Notes

We have seen its presence at gsutil and also `gcloud config set disable_usage_reporting false` for usage data.
