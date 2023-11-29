{
  services.deluge = {
    enable = true;
    openFirewall = true;
    
    # web daemon
    web.enable = true;
    web.openFirewall = true;

    # to access media
    group = "removable-storage";
  };
}
