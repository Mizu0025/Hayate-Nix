{ config, lib, pkgs, ... }:

let
  app = "magical-hayate";
  domain = "${app}.net";
  generateErrorPages = codes: lib.concatMapStringsSep " " (code: "error_page ${toString code} /error.php?code=$status;") codes;
in {
  services.phpfpm.pools.${app} = {
    user = app;
    settings = {
      "listen.owner" = config.services.nginx.user;
      "pm" = "dynamic";
      "pm.max_children" = 32;
      "pm.max_requests" = 500;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 2;
      "pm.max_spare_servers" = 5;
      "php_admin_value[error_log]" = "stderr";
      "php_admin_flag[log_errors]" = true;
      "catch_workers_output" = true;
    };
    phpEnv."PATH" = lib.makeBinPath [ pkgs.php ];
  };
  users.users.${app} = {
    isSystemUser = true;
    createHome = true;
    home = "/srv/http/${domain}";
    group = app;
  };
  users.groups.${app} = {};

  # allows access to artbot folder
  systemd.services.nginx.serviceConfig = {
    SupplementaryGroups = [ "artbot" ];
  };
  
  services.nginx = {
    enable = true;
    # by default nginx times out connections in one minute
    proxyTimeout = "1d";

    virtualHosts."${domain}" = {
      enableACME = true;
      forceSSL = true; # Redirect HTTP to HTTPS
      serverAliases = [ "www.magical-hayate.net" ];
      root = "/var/www/magical-hayate.net";

      # error handling
      extraConfig = ''
      ${generateErrorPages [400 401 403 404 500 502 503]}
      '';

      locations."/error" = {
	fastcgiParams = {
		SCRIPT_FILENAME = "/var/www/${domain}/error.php";
        	SCRIPT_NAME = "/error.php";
	};
	extraConfig = ''
	fastcgi_pass unix:${config.services.phpfpm.pools.${app}.socket};
        include ${pkgs.nginx}/conf/fastcgi_params;
	'';
      };

      locations."/pictures" = {
        fastcgiParams = {
	SCRIPT_FILENAME = "/var/www/${domain}/gallery.php";
	SCRIPT_NAME = "/gallery.php";
	  };
	extraConfig = ''
	fastcgi_pass unix:${config.services.phpfpm.pools.${app}.socket};
        include ${pkgs.nginx}/conf/fastcgi_params;
	'';
      };

      locations."/comfyui/" = {
	alias = "/artbot/";
	extraConfig = ''
		autoindex on; 
		autoindex_exact_size off; 
		autoindex_localtime on;
	'';
      };
    };

    virtualHosts."thelounge.${domain}" = {
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
