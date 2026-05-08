{
  self,
  inputs,
  utils,
  username,
  ...
}:
{

  modules.programs.dots_mango = utils.mkDotsModule username {
    "mango/animation.conf" = "/mango/animation.conf";
    "mango/autostart.sh" = "/mango/autostart.sh";
    "mango/bind.conf" = "/mango/bind.conf";
    "mango/env.conf" = "/mango/env.conf";
    "mango/rules.conf" = "/mango/rules.conf";
    "mango/hardware.conf" = d: d.dotsDir + "/mango/${d.lib.toLower d.config.networking.hostName}.conf";
    "mango/config.conf" = "/mango/config.conf";
  };
  modules.wm.mango =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        self.modules.wm._
        inputs.mango.nixosModules.mango
      ];
      options = {
        wm.mango.enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
      };

      config = (lib.mkIf config.wm.mango.enable) {
        programs.mango = {
          enable = true;
        };

        xdg.portal = {
          config.mango = {
            "org.freedesktop.impl.portal.FileChooser" = lib.mkForce "kde";
            # "org.freedesktop.impl.portal.ScreenCast" = "gnome";
            # "org.freedesktop.portal.ScreenCast" = "gnome";
          };
        };

        environment.systemPackages = [
          pkgs.fuzzel
          pkgs.kitty
        ];
      };
    };
}
