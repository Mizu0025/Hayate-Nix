{
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 
	# nginx
	80 443 
	
	# irc client
	9000 

	# gluetun vpn
        8888 8388

	# deluge
        8112 6881

	# artbot comfyui
	8188
  ];
  networking.firewall.allowedUDPPorts = [ 
	# nginx 
	80 443 

	# irc client
	9000 

	# gluetun vpn
	8388

	# deluge
	6881
  ];

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
