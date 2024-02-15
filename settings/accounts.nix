{ config, pkgs, ... }:

{
  # contents of /etc/passwd and /etc/group are congruent to here

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    liam = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    };

    jellyfin = {
      extraGroups = [ "render" ]; # allow transcoding
    };
  };

  users.groups = {
    removable-storage = {
	members = [ "liam, jellyfin, sonarr, radarr, deluge" ];
	gid = 988;
    };
    artbot = {
	members = [ "liam" ];
    };
  };
}
