#!/usr/bin/env bash
set -euxo pipefail

RELEASE=$1

echo "Running hooks for release $RELEASE"

# if [ "$RELEASE" = provision-configs ]; then
#     rsync -a --exclude 'values.yaml*' configs/kano/ provision-configs/.data/kano
# fi
