{
  modules.hosts.hana =
    { pkgs, ... }:
    {
      services.hardware.openrgb.enable = false;
      environment.systemPackages = [
        pkgs.openrgb-with-all-plugins
      ];
    };
}
