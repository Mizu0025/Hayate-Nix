let 
  USERID = "1000"; # liam
  GROUPID = "988"; # removable-storage
in
{
  networking.firewall.allowedTCPPorts = [
        # gluetun
        8888 # HTTP proxy
        8388 # Shadowsocks

        # deluge
        8112
        6881

        # prowlarr
        9696

	# sonarr 
	8989

	# radarr
	7878
  ];
  networking.firewall.allowedUDPPorts = [
        # gluetun
        8388 # Shadowsocks

        # deluge
        6881
  ];
 
  virtualisation.oci-containers.backend = "docker";

  virtualisation.oci-containers.containers."gluetun" = {
        image = "qmcgaw/gluetun";
        hostname = "gluetun";
        ports = [
        "8888:8888"
        "8388:8388"
        "8112:8112" # deluge
        "6881:6881" # deluge
	"9696:9696" # prowlarr
	"8989:8989" # sonarr
	"7878:7878" # radarr
        ];
        environmentFiles = [
          /etc/nixos/virtualisation/env-gluetun.txt
        ];
        environment = {
          TZ = "Australia/Melbourne";
        };
        volumes = [
          "/var/lib/gluetun:/gluetun"
        ];
	extraOptions = [
	  "--cap-add=NET_ADMIN"
	];
  };

  virtualisation.oci-containers.containers."deluge" = {
        image = "lscr.io/linuxserver/deluge:latest";
        dependsOn = [
          "gluetun"
        ];
        environment = {
	  PUID = USERID;
	  PGID = GROUPID;
          TZ = "Australia/Melbourne";
          DELUGE_LOGLEVEL = "info";
	};
        volumes = [
          "/var/lib/deluge:/config"
          "/media/Downloads:/media/Downloads"
        ];
	extraOptions = [
	  "--network=container:gluetun"
	];
  };

  virtualisation.oci-containers.containers."prowlarr" = {
        image = "lscr.io/linuxserver/prowlarr:latest";
        dependsOn = [
          "gluetun"
        ];
        environment = {
	  PUID = USERID;
	  PGID = GROUPID;
          TZ = "Australia/Melbourne";
        };
        volumes = [
          "/var/lib/prowlarr:/config"
        ];
	extraOptions = [	  
	  "--network=container:gluetun"
	];
  };

  virtualisation.oci-containers.containers."sonarr" = {
        image = "lscr.io/linuxserver/sonarr:latest";
        dependsOn = [
          "gluetun"
        ];
        environment = {
	  PUID = USERID;
	  PGID = GROUPID;
          TZ = "Australia/Melbourne";
        };
        volumes = [
          "/var/lib/sonarr:/config"
	  "/media/TVShows:/media/TVShows"
	  "/media/Downloads:/media/Downloads"
        ];
	extraOptions = [	  
	  "--network=container:gluetun"
	];
  };

  virtualisation.oci-containers.containers."radarr" = {
        image = "lscr.io/linuxserver/radarr:latest";
        dependsOn = [
          "gluetun"
        ];
        environment = {
	  PUID = USERID;
	  PGID = GROUPID;
          TZ = "Australia/Melbourne";
        };
        volumes = [
          "/var/lib/radarr:/config"
	  "/media/Movies:/media/Movies"
	  "/media/Downloads:/media/Downloads"
        ];
	extraOptions = [	  
	  "--network=container:gluetun"
	];
  };
}
