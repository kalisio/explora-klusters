#!/usr/bin/env bash
set -euxo pipefail

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_PATH=$(dirname "$THIS_FILE")
CLUSTER_PATH=$(dirname "$THIS_PATH")

export KUBECONFIG="$CLUSTER_PATH/kubeconfig.dec.yml"

# Key file containing identities used to decrypt secrets
# This is used by sops, which is also used by helm-secrets plugin
export SOPS_AGE_KEY_FILE="$DEVELOPMENT_DIR/age/keys.txt"

KUBECONFIG_ENC=$(dirname "$KUBECONFIG")/$(basename "$KUBECONFIG" .dec.yml).enc.yml
sops --decrypt --output "$KUBECONFIG" "$KUBECONFIG_ENC"

cd "$THIS_PATH" && helmfile --concurrency 4 sync
