{
  inputs,
  with-inputs,
  pkgs,
  ...
}:
{
  modules.programs.sysc-greet = {
    imports = [ with-inputs.sysc-greet.nixosModules.default ];
    services.sysc-greet = {
      enable = true;
      compositor = "niri";
      hyprlandPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      niriPackage = pkgs.niri;
    };
  };
}
