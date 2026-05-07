{
  modules.hosts.kagura = {
    misc.steam.enable = false;
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    services.xserver.videoDrivers = [
      "modesetting"
      "nvidia"
    ];
  };
}
