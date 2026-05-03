{
  modules.hosts.kagura =
    { pkgs, ... }:
    {
      services.hardware.openrgb.enable = false;
      environment.systemPackages = [
        pkgs.openrgb-with-all-plugins
      ];
    };
}
