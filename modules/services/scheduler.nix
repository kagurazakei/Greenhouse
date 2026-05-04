{
  inputs,
  ...
}:
{
  modules.services.scheduler = {
    imports = [ inputs.chaotic.nixosModules.default ];
    chaotic.nyx.overlay.enable = true;
    services.scx = {
      enable = true;
      scheduler = "scx_lavd";
    };
    systemd.services.scx.environment = {
      SCX_SCHEDULER_OVERRIDE = "scx_lavd";
    };
  };
}
