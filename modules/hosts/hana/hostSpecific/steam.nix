{
  modules.hosts.hana = {
    misc.steam.enable = true;
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    services.xserver.videoDrivers = [
      "amdgpu"
      "nvidia"
    ];
  };
}
