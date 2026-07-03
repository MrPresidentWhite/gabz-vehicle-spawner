#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RESOURCE_NAME="gabz-vehicle-spawner"
OUTPUT_DIR="${ROOT_DIR}/dist"
STAGING_DIR="${OUTPUT_DIR}/${RESOURCE_NAME}"

rm -rf "${OUTPUT_DIR}"
mkdir -p "${STAGING_DIR}"

cp "${ROOT_DIR}/fxmanifest.lua" "${STAGING_DIR}/"
cp "${ROOT_DIR}/config.lua" "${STAGING_DIR}/"
cp -r "${ROOT_DIR}/client" "${STAGING_DIR}/"
cp -r "${ROOT_DIR}/server" "${STAGING_DIR}/"
cp -r "${ROOT_DIR}/shared" "${STAGING_DIR}/"
cp -r "${ROOT_DIR}/locales" "${STAGING_DIR}/"
cp -r "${ROOT_DIR}/html" "${STAGING_DIR}/"

if [[ ! -f "${STAGING_DIR}/fxmanifest.lua" ]]; then
  echo "Build validation failed: fxmanifest.lua is missing in staging directory."
  exit 1
fi

echo "Release asset staged at ${STAGING_DIR}"