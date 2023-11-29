{ config, pkgs, ... }:

{
  services.nginx = {
    enable = true;

    virtualHosts."magical-hayate.net" = {
      enableACME = true;
      forceSSL = true; # Redirect HTTP to HTTPS
      root = "/var/www/magical-hayate.net";
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "liamash3@gmail.com";
  };
}

