{ config, pkgs, ... }:

{
  services.nginx = {
    enable = true;
    # by default nginx times out connections in one minute
    proxyTimeout = "1d";

    virtualHosts."magical-hayate.net" = {
      enableACME = true;
      forceSSL = true; # Redirect HTTP to HTTPS
      serverAliases = [ "www.magical-hayate.net" ];
      root = "/var/www/magical-hayate.net";

      locations."/pictures" = {
        fastcgiParams = {
	SCRIPT_FILENAME = "/var/www/magical-hayate.net/gallery.php";
	SCRIPT_NAME = "/gallery.php";
	  };
      };
    };

    virtualHosts."thelounge.magical-hayate.net" = {
	enableACME = true;
	forceSSL = true;

	locations."/" = {
	  proxyPass = "http://127.0.0.1:9000";
	  proxyWebsockets = true;
	  recommendedProxySettings = true;
	};

	locations."/uploads/" = {
	  proxyPass = "http://127.0.0.1:9000/uploads/";
	  proxyWebsockets = true;
	  recommendedProxySettings = true;
	};
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "liamash3@gmail.com";
  };
}
