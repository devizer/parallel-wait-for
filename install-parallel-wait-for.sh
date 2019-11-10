#!/usr/bin/env sh
# two optional parameters: INSTALL_DIR (default is /opt/parallel-wait-for) and LINK_DIR (default is /usr/local/bin)
# script=https://raw.githubusercontent.com/devizer/parallel-wait-for/master/install-parallel-wait-for.sh; (wget -q -nv --no-check-certificate -O - $script 2>/dev/null || curl -ksSL $script) | sh

set -e
set -u

rid=unknown
machine="$(uname -m || true)"; machine="${machine:-unknown}"
case $machine in
  "armv7"*)                     rid=linux-arm;   ;;
  "armv8"*|"aarch64"*|"arm64"*) rid=linux-arm64; ;;
  "amd64"*|"x86_64"*)           rid=linux-x64;   ;;
  *)                                             ;;
esac

kname="$(uname -s || true)"; kname="${kname:-unknown}"
case $kname in
  "Darwin"*)  rid=osx-x64 ;;
  "MSYS"*)    rid=win-x64; echo "For windows please use powershell installer" >&2; exit 1 ;;
esac


if [ -e /etc/os-release ]; then
  . /etc/os-release
  if [ "${ID:-}" = "alpine" ]; then
    rid=linux-musl-x64;
  fi
elif [ -e /etc/redhat-release ]; then
  redhatRelease=$(</etc/redhat-release)
  case $redhatRelease in 
    "CentOS release 6."*)                           rid=rhel.6-x64 ;;
    "Red Hat Enterprise Linux Server release 6."*)  rid=rhel.6-x64 ;;
  esac
fi

echo "The runtime identifier: $rid"

file=parallel-wait-for-$rid.tar.gz
url=https://raw.githubusercontent.com/devizer/parallel-wait-for/master/public/$file
copy=$HOME/$file

INSTALL_DIR="${INSTALL_DIR:-/opt/parallel-wait-for}"
LINK_DIR="${LINK_DIR:-/usr/local/bin}"

if [ "${INSTALL_DIR}" = "/" ]; then
    echo "Installing to the root is not available"
    exit 1;
fi

echo "downloading $url ..."
wget --no-check-certificate -O "$copy" "$url"  || curl -kfSL -o "$copy" "$url"
cmd1="mkdir -p \"$INSTALL_DIR\""
cmd2="rm -f \"$INSTALL_DIR/*\""
cmd2a="tar xzf \"$copy\" -C \"$INSTALL_DIR\""
if [ -n "${LINK_DIR:-}" ]; then
    cmd3="ln -s -f \"$INSTALL_DIR/WaitFor\" \"$LINK_DIR/parallel-wait-for\" && echo link to parallel-wait-for installed into $LINK_DIR"
else
    cmd3="echo WaitFor installed: $INSTALL_DIR/WaitFor"
fi
for cmd in "$cmd1" "$cmd2" "$cmd2a" "$cmd3"; do
    sudo true >/dev/null 2>&1 && eval "sudo $cmd" || eval "$cmd"
done
rm -rf "$copy" || true
