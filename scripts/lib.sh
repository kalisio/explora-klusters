#!/usr/bin/env bash

# This expects a few env vars to be setup
#  - SOPS_AGE_KEY_FILE is the path to your AGE private key. If not set,
#  assume we have a DEVELOPMENT_DIR defined with the key file in there.
#
# You typically include thie file using the following snippet:
#
# 8< -------------------------------
# THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
# THIS_DIR=$(dirname "$THIS_FILE")
# ROOT_DIR=$(dirname "$THIS_DIR")
#
# . "$THIS_DIR/lib.sh" "$ROOT_DIR"
# ------------------------------- >8

REPO_ROOT="$1"

decrypt_secrets() {
    local NAMESPACE=$1

    export KUBECONFIG="$REPO_ROOT/clusters/loradata/kubeconfig.dec.yaml"

    # Manually decrypt required files
    if [ -z "${SOPS_AGE_KEY_FILE:-}" ]; then
        export SOPS_AGE_KEY_FILE="$DEVELOPMENT_DIR/age/keys.txt"
    fi

    sops --decrypt --output "$KUBECONFIG" "$(dirname "$KUBECONFIG")/$(basename "$KUBECONFIG" .dec.yaml).enc.yaml"
    sops --decrypt --output "$REPO_ROOT/namespaces/$NAMESPACE/secret.dec.yaml" "$REPO_ROOT/namespaces/$NAMESPACE/secret.enc.yaml"
}
