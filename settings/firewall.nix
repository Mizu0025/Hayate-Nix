{
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 443 9000 ];
  networking.firewall.allowedUDPPorts = [ 80 443 9000 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
