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
          TZ = "Australia/Melbourne";
          DELUGE_LOGLEVEL = "info";
	  PUID = "1000";
	  GUID = "988";
        };
        volumes = [
          "/var/lib/deluge:/config"
          "/media/Downloads:/downloads"
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
          TZ = "Australia/Melbourne";
	  PUID = "1000";
	  GUID = "100";
        };
        volumes = [
          "/var/lib/prowlarr:/config"
        ];
	extraOptions = [
	  "--network=container:gluetun"
	];
  };
}
