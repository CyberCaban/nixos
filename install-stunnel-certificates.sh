#!/usr/bin/env bash
set -euo pipefail

if [[ ${EUID} -ne 0 ]]; then
  exec sudo -- "$0" "$@"
fi

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
credential_dir=/home/dmitry/installs/ovpn3-tensor/dev

install -Dm0644 "$credential_dir/servercert.pem" /etc/stunnel/servercert.pem
install -Dm0644 "$credential_dir/clientcert.pem" /etc/stunnel/clientcert.pem
install -Dm0600 "$credential_dir/clientkey.pem" /etc/stunnel/clientkey.pem

nixos-rebuild switch --flake "$repo_dir#nixos"
chown root:stunnel /etc/stunnel/clientkey.pem
chmod 0640 /etc/stunnel/clientkey.pem
systemctl restart stunnel-tensor.service
systemctl --no-pager --full status stunnel-tensor.service
