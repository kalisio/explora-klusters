#!/usr/bin/env bash
set -euxo pipefail

NAMESPACE=${1}

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "$THIS_FILE")
ROOT_DIR=$(dirname "$THIS_DIR")

. "$THIS_DIR/lib.sh" "$ROOT_DIR"

# Decrypt required files
decrypt_secrets "$NAMESPACE"

# And run helmfile with proper options
cd "$ROOT_DIR/namespaces/$NAMESPACE"
helmfile --namespace "$NAMESPACE" --selector action=config --selector action=install --concurrency 4 sync
cd ~-
