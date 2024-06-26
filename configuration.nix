# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # boot
      ./settings/boot.nix
      ./settings/desktop.nix

      # accounts
      ./settings/accounts.nix

      # packages
      ./settings/packages.nix

      # networking
      ./settings/networking.nix
      ./settings/firewall.nix

      # hardware acceleration
      ./settings/hardware-accel.nix

      # artbots
      ./services/comfyui.nix

      # media management
      ./services/jellyfin.nix
      ./services/virtualisation.nix
      ./services/samba.nix
      ./services/syncthing.nix

       # web server
      ./services/nginx.nix
      ./services/thelounge.nix
    ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

