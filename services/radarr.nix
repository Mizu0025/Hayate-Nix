{
  services.jellyfin = {
    enable = true;
    openFirewall = true;

    # to allow media access
    group = "removable-storage";
  };
}
