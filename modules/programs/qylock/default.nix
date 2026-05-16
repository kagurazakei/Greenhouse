{
  inputs,
  pkgs,
  ...
}:
{
  modules.programs.qylock = {
    imports = [ inputs.qylock.nixosModules.default ];
    services.qylock = {
      enable = true;
      theme = "pixel-night-city";
      sddmTheme = "pixel-night-city";
      sddmThemeFont = [ "./PixelifySans-Bold.ttf" ];
    };
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
