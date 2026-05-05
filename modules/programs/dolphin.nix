{
  modules.programs.dolphin =
    {
      pkgs,
      config,
      ...
    }:
    {
      environment.systemPackages = with pkgs.kdePackages; [
        dolphin
        dolphin-plugins
        gwenview
        ark
        kservice
        kde-cli-tools
        ffmpegthumbs
        kio
        kio-extras
        kio-fuse
        kimageformats
        kdegraphics-thumbnailers
        kirigami
      ];
      hj.xdg.config.files = {
        "dolphinrc".source = config.impure-dots + "/dolphinrc";
        "menus/applications.menu".source = config.impure-dots + "/menus/applications.menu";
        "kdeglobals".source = config.impure-dots + "/kdeglobals";
      };
    };
}
