{
  inputs,
  ...
}:
{
  modules.programs.ambxst = {
    imports = [
      inputs.noc-ambxst.nixosModules.default
    ];
    programs.ambxst = {
      enable = true;
      fonts.enable = true;
    };
  };
}
