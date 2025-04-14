#!/bin/bash
set -e

if [ -z "$ISO_FILE" ]; then
  echo "Error: ISO_FILE environment variable not set."
  exit 1
fi

if [ -z "$ISO_MOUNT_PATH" ]; then
  echo "Error: ISO_MOUNT_PATH environment variable not set."
  exit 1
fi

ISO_PATH="./data/${ISO_FILE}"

mkdir -p $ISO_MOUNT_PATH

echo "Mounting ISO: $ISO_PATH to $ISO_MOUNT_PATH"

mount -o loop,ro "$ISO_PATH" "$ISO_MOUNT_PATH"

if [ $? -ne 0 ]; then
  echo "Error mounting ISO."
  exit 1
fi

# Execute the command provided by CMD (default to starting the server)
if [ -n "$1" ]; then
  # Use all arguments passed via CMD
  exec $@
else
  echo "No command specified in CMD"
fi
