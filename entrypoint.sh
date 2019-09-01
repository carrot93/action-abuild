#!/bin/sh

set -eu

# Bail out (but report success) if there's no work to do
if [ -f "$GITHUB_WORKSPACE/.env/NOTHING_TO_DO" ]; then
  exit 0
fi

function export_to_env {
  name=$(echo $1 | awk '{ print toupper($0)}')
  value=$(cat "$GITHUB_WORKSPACE"/.env/$1)
  export $name="$value"
}

for var in $(ls "$GITHUB_WORKSPACE"/.env); do
  export_to_env $var
done

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
