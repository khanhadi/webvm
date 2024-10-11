#!/bin/bash

# Build the Docker image
docker build -t xv6-webvm .

# Create a container from the image
docker create --name xv6-container xv6-webvm

# Create a directory to hold the filesystem
mkdir -p cheerpXFS

# Copy the filesystem from the container
docker cp xv6-container:/ cheerpXFS/

# Create a raw disk image (1GB size)
dd if=/dev/zero of=xv6-webvm.raw bs=1M count=1024

# Format the raw image as ext2 and populate it with the filesystem contents
$(brew --prefix e2fsprogs)/sbin/mkfs.ext2 -d cheerpXFS xv6-webvm.raw

# Rename the image
mv xv6-webvm.raw xv6-webvm.ext2

# Clean up
docker rm xv6-container
docker rmi xv6-webvm
rm -rf cheerpXFS

echo "xv6-webvm.ext2 has been created successfully."