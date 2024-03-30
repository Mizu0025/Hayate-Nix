{
 services.samba = {
  enable = true;
  securityType = "user";
  openFirewall = true;
  extraConfig = ''
    workgroup = WORKGROUP
    server string = smbnix
    netbios name = smbnix
    security = user 
    #use sendfile = yes
    #max protocol = smb2
    # note: localhost is the ipv6 localhost ::1
    hosts allow = 192.168.50. 127.0.0.1 localhost
    hosts deny = 0.0.0.0/0
    # guest account = nobody
    # map to guest = bad user
  '';
  shares = {
    writing = {
      path = "/writing";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "no";
      "valid users" = "liam";
      "create mask" = "0644";
      "directory mask" = "0755";
      # "force user" = "liam";
      # "force group" = "users";
    };
  };
};

services.samba-wsdd = {
  enable = true;
  openFirewall = true;
};

networking.firewall.enable = true;
networking.firewall.allowPing = true;
}

