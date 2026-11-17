{ ... }:

{
  # The OpenVPN 3 D-Bus services shipped by pkgs.openvpn3 run as this user.
  users.groups.openvpn = { };
  users.users.openvpn = {
    isSystemUser = true;
    group = "openvpn";
  };

  # The configuration manager persists profiles in this directory.
  systemd.tmpfiles.rules = [
    "d /etc/openvpn3/configs 0750 openvpn openvpn -"
  ];
}
