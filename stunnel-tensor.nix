{ config, pkgs, ... }:

{
  users.groups.stunnel = { };
  users.users.stunnel = {
    isSystemUser = true;
    group = "stunnel";
  };

  environment.systemPackages = [ pkgs.stunnel ];

  environment.etc."stunnel/stunnel.conf".source = ./stunnel/tensor.conf;

  systemd.services.stunnel-tensor = {
    description = "stunnel tunnel for Tensor OpenVPN";
    documentation = [ "man:stunnel(8)" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    restartTriggers = [ config.environment.etc."stunnel/stunnel.conf".source ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.stunnel}/bin/stunnel /etc/stunnel/stunnel.conf";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}
