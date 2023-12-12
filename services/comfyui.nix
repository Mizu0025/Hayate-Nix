{ config, lib, pkgs, ... }:

let
  COMFYUI_DIR = "/home/liam/Stable-Diffusion/ComfyUI";
  # BOT_DIR = "/home/svein/AI/image-generation/sd-bot-2";

  comfyui = {
    description = "ComfyUI";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    path = [];
    serviceConfig = {
      User = "liam";
      WorkingDirectory = COMFYUI_DIR;
      Type = "simple";
      Restart = "on-failure";
      Environment = "";
      ExecStart = "${pkgs.steam-run}/bin/steam-run " + COMFYUI_DIR + "/run-comfy.sh";
      MemoryMax = "12G";
    };
  };

  # The bot's a simple javascript app
/*
  bot = {
    description = "sd-bot";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    path = [ pkgs.nix pkgs.cached-nix-shell ];
    serviceConfig = {
      User = "svein";
      WorkingDirectory = BOT_DIR;
      Type = "simple";
      Restart = "on-failure";
      Environment = "NIX_PATH=nixpkgs=/etc/nixpkgs";
      ExecStart = "${BOT_DIR}/start.sh";
    };
*/
in
{
  systemd.services.comfyui = comfyui;
#  systemd.services.sd-bot = bot;

#  networking.firewall.allowedTCPPorts = [ 8188 ];
}
