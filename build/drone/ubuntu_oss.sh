#!/bin/sh

set -ue

apt-get update -y
apt-get install -y -q squashfs-tools build-essential ruby bison ruby-dev git-core texinfo curl openssl tzdata

update-ca-certificates

curl -sL https://github.com/kontena/ruby-packer/releases/download/0.5.0%2Bextra7/rubyc-0.5.0+extra7-linux-amd64.gz | gunzip > /usr/local/bin/rubyc
chmod +x /usr/local/bin/rubyc

rm -rf non-oss/

version=${DRONE_TAG#"v"}
package="pharos-cluster-linux-amd64-${version}+oss"
mkdir -p /root/.pharos/build
rubyc --openssl-dir=/etc/ssl -o "$package" -d /root/.pharos/build --make-args=--silent pharos
rm -rf /root/.pharos/build
./"$package" version

# ship to github
curl -sL https://github.com/aktau/github-release/releases/download/v0.7.2/linux-amd64-github-release.tar.bz2 | tar -xjO > /usr/local/bin/github-release
chmod +x /usr/local/bin/github-release
/usr/local/bin/github-release upload \
    --user kontena \
    --repo pharos-cluster \
    --tag "$DRONE_TAG" \
    --name "$package" \
    --file ./"$package"
