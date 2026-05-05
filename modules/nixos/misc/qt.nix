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
        qt5.qtgraphicaleffects
        libsForQt5.kdeclarative
      ];

      hjem.users.${username}.packages = with pkgs; [
        (catppuccin-papirus-folders.override {
          flavor = "mocha";
          accent = "red";
        })
      ];

      environment.variables = {
        QT_PLUGIN_PATH = lib.makeSearchPathOutput "qt6" "lib/qt-6/plugins" [
          pkgs.kdePackages.qqc2-desktop-style
        ];

        # This is what's missing - QML import paths for ambxst
        QML2_IMPORT_PATH =
          lib.makeSearchPathOutput "qt6" "lib/qt-6/qml" [
            pkgs.kdePackages.qqc2-desktop-style
            pkgs.kdePackages.kirigami
            pkgs.kdePackages.kirigami-addons
            pkgs.qt6.qtdeclarative
            pkgs.qt6.qtbase
            pkgs.qt6.qt5compat
          ]
          + ":"
          + lib.makeSearchPathOutput "qt5" "lib/qt-5.15/qml" [
            pkgs.libsForQt5.kdeclarative
            pkgs.qt5.qtdeclarative
            pkgs.qt5.qtgraphicaleffects
            pkgs.libsForQt5.qt5.qtgraphicaleffects
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
