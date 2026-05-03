{
  modules.nixos.ambxst =
    {
      inputs,
      ...
    }:
    {
      imports = [
        inputs.ambxst.nixosModules.default
      ];
      programs.ambxst = {
        enable = true;
        fonts.enable = true;
      };
    };
}
