{ config, pkgs, ... }:

{
  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     # general
     vim
     wget
     git
     docker
     docker-compose

     # ai artbot
     steam-run

     # motd
     figlet

     # web server
     nginx
     php

     # irc
     thelounge

     # media
     jellyfin
     jellyfin-web
     jellyfin-ffmpeg

     # media management
     sonarr
     radarr

     # torrents
     deluge
   ];
}
