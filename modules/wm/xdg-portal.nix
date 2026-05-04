{
  modules.wm._ =
    { pkgs, ... }:
    {
      programs.uwsm = {
        enable = true;
        waylandCompositors = {
          hyprland = {
            prettyName = "Hyprland";
            comment = "Sway compositor managed by UWSM";
            binPath = "/run/current-system/sw/bin/start-hyprland";
          };
        };
      };
      xdg.portal = {
        enable = true;
        configPackages = [
          pkgs.kdePackages.xdg-desktop-portal-kde
          # pkgs.xdg-desktop-portal-gtk
        ];
        extraPortals = [
          pkgs.kdePackages.xdg-desktop-portal-kde
          pkgs.xdg-desktop-portal-gtk
        ];
      };
    };
}
