{ config, lib, pkgs, ... }:

let
  COMFYUI_DIR = "/home/liam/Stable-Diffusion/ComfyUI";
  BOT_DIR = "/home/liam/coding/Fate-chan-v2";

  comfyui = {
    description = "ComfyUI";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    path = [];
    serviceConfig = {
      User = "liam";
      Group = "artbot";
      WorkingDirectory = COMFYUI_DIR;
      Type = "simple";
      Restart = "on-failure";
      Environment = "";
      ExecStart = "${pkgs.steam-run}/bin/steam-run " + COMFYUI_DIR + "/run-comfy.sh";
      MemoryMax = "12G";
    };
  };

  bot = {
    description = "sd-bot";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    path = [ pkgs.nix pkgs.cached-nix-shell ];
    serviceConfig = {
      User = "liam";
      Group = "nginx"; # to access ssl certs
      WorkingDirectory = BOT_DIR;
      Type = "simple";
      Restart = "on-failure";
      Environment = "";
      ExecStart = "${pkgs.steam-run}/bin/steam-run " + BOT_DIR + "/start.sh";
    };
  };

in
{
  systemd.services.comfyui = comfyui;
  systemd.services.sd-bot = bot;

#  networking.firewall.allowedTCPPorts = [ 8188 ];
}
