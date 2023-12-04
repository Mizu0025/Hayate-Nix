{ config, pkgs, ... }:

{
  hardware.nvidia.modesetting.enable = false;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  services.xserver.videoDrivers = ["nvidia"];
  boot.kernelParams = [ "module_blacklist=nouveau" ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
