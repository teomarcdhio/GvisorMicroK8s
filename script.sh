#!/bin/sh
set -e
while :
do
  if [ -f /local/version.txt ]
  then
    VER=$(cat /local/version.txt)
    echo "Gvisor ${VER} version is installed"
    sleep 30
  else
    echo "Gviso is not installed; installing now"
    ARCH=$(uname -m)
    URL=https://storage.googleapis.com/gvisor/releases/release/$1/${ARCH}
    wget ${URL}/runsc ${URL}/runsc.sha512 ${URL}/containerd-shim-runsc-v1 ${URL}/containerd-shim-runsc-v1.sha512
    # sha512sum -c runsc.sha512 -c containerd-shim-runsc-v1.sha512
    rm -f *.sha512
    chmod a+rx runsc containerd-shim-runsc-v1
    mv runsc containerd-shim-runsc-v1 /local$2
    # Locate the microk8s containerd template and replace the content as per template; this is a shortcut as microk8s handles containerd config file in a "funny" way.
    filelocation=$(find /local/var/snap/microk8s/7* -name containerd-template.toml)
    echo $filelocation
    > $filelocation
    cat containerd-template.toml > $filelocation
    touch /local/version.txt
    echo "Version ${1}" > /local/version.txt
    # Restart microk8s that will in turn restart containerd
    /usr/bin/nsenter -m/proc/1/ns/mnt -- snap restart microk8s
  fi
done






