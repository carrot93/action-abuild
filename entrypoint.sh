#!/bin/sh

set -eu

# Generate a temporary key for abuild
mkdir "$GITHUB_WORKSPACE"/.abuild
echo "$GITHUB_WORKSPACE/key" | abuild-keygen
echo PACKAGER_PRIVKEY="$GITHUB_WORKSPACE/key" > "$HOME"/.abuild/abuild.conf

cd "$GITHUB_WORKSPACE/$INPUT_PACKAGE_PATH"

# Fetch latest from upstream since this fork may be out of date
git remote add upstream https://github.com/alpinelinux/aports.git
git fetch upstream && git reset --hard upstream/master

# Update the package version
sed -i "s/pkgver=.*/pkgver=$INPUT_RELEASE_VERSION/g" APKBUILD

# Build the package
abuild -F checksum && abuild -F -r
