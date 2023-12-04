{ config, pkgs, ... }:

{
  services.nginx = {
    enable = true;

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
	  extraConfig = ''
		proxy_set_header Connection "upgrade";
		proxy_set_header Upgrade $http_upgrade";
		proxy_set_header X-Forwarded-For $remote_addr";
		proxy_set_header X-Forwarded-Proto $scheme";

		# by default nginx times out connections in one minute
		proxy_read_timeout 1d;
	'';
	};

	locations."/uploads/" = {
	  proxyPass = "http://127.0.0.1:9000/uploads/";
	  proxyWebsockets = true;
	  extraConfig = ''proxy_set_header X-Forwarded-For $remote_addr;'';
	};
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "liamash3@gmail.com";
  };
}

