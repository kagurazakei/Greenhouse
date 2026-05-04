{
  inputs,
  ...
}:
{
  modules.nixos.ambxst = {
    imports = [
      inputs.ambxst.nixosModules.default
    ];
    programs.ambxst = {
      enable = true;
      fonts.enable = true;
    };
  };
}
