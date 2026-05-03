{
  modules.hosts.kagura = {
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
