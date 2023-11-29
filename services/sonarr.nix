{
  services.sonarr = {
    enable = true;
    openFirewall = true;

    # to allow media access
    group = "removable-storage";
  };
}
