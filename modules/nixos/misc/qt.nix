{ username, ... }:
{
  modules.nixos.misc =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      qt.enable = true;
      environment.systemPackages = with pkgs; [
        wlsunset
        libqalculate
        libsForQt5.qtstyleplugin-kvantum
        libsForQt5.qt5ct
        kdePackages.qqc2-desktop-style
        adwaita-qt6
        qt6.qtwayland
        qt6.qtsvg
        qt6Packages.qtstyleplugin-kvantum
        kdePackages.kdialog
        kdePackages.qtpositioning
        kdePackages.qtshadertools
        kdePackages.syntax-highlighting
        kdePackages.qtbase
        kdePackages.qtdeclarative
        kdePackages.qtmultimedia
        kdePackages.qt5compat
        kdePackages.sonnet
        kdePackages.kirigami
        kdePackages.kirigami-addons
        kdePackages.breeze
        libsForQt5.qt5.qtgraphicaleffects
        qt5.qtbase
        qt5.qtdeclarative
        qt5.qtquickcontrols2
        qt5.qtgraphicaleffects
        libsForQt5.qqc2-desktop-style
        libsForQt5.kdeclarative
      ];
      hjem.users.${username}.packages = with pkgs; [
        (catppuccin-papirus-folders.override {
          flavor = "mocha";
          accent = "red";
        })
      ];
      environment.variables = {
        QT_PLUGIN_PATH = [
          "${pkgs.kdePackages.qqc2-desktop-style}/${pkgs.kdePackages.qtbase.qtPluginPrefix}"
        ];

        QML2_IMPORT_PATH = lib.concatStringsSep ":" [
          "${pkgs.kdePackages.qqc2-desktop-style}/${pkgs.kdePackages.qtbase.qtQmlPrefix}"
          "${pkgs.kdePackages.kirigami}/lib/qt-6/qml"
          "${pkgs.qt6.qt5compat}/lib/qt6/qml"
          "${pkgs.libsForQt5.qt5.qtgraphicaleffects}/lib/qt-5.15.18/qml"
          "${pkgs.qt6.qtbase}/lib/qt6/qml"
        ];
      };
      hj = {
        xdg.config.files = {
          "qt6ct/qt6ct.conf".source = config.impure-dots + "/qt6ct/qt6ct.conf";
          "qt6ct/colors".source = config.impure-dots + "/qt6ct/colors";
          "qt5ct/qt5ct.conf".source = config.impure-dots + "/qt5ct/qt5ct.conf";
          "qt5ct/colors".source = config.impure-dots + "/qt5ct/colors";
          "Kvantum/kvantum.kvconfig".source = config.impure-dots + "/Kvantum/kvantum.kvconfig";
          "Kvantum/rose-pine-iris".source = config.impure-dots + "/Kvantum/rose-pine-iris";
          "Kvantum/rose-pine-love".source = config.impure-dots + "/Kvantum/rose-pine-love";
        };
      };
    };
}
