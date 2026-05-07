{
  lib,
  stdenvNoCC,
  symlinkJoin,
  makeWrapper,
  quickshell,
  kdePackages,
  material-symbols,
  makeFontsConf,
  nerd-fonts,
  qt6,
  configPath ? ../dots/quickshell/ambxst,
  asGreeter ? false,
  customColors ? null,
}:

let
  inherit (lib)
    makeSearchPath
    optionalString
    any
    optionals
    ;

  # Collect all runtime dependencies
  runtimeDeps = [
    quickshell
    kdePackages.kirigami
    kdePackages.kirigami-addons
    kdePackages.qqc2-desktop-style
    kdePackages.qtdeclarative
    kdePackages.qtmultimedia
    kdePackages.kwindowsystem
    qt6.qtdeclarative
    qt6.qtbase
    qt6.qtmultimedia
    qt6.qtsvg
    qt6.qtwayland
  ];

  # QML import paths for Qt6
  qmlPath = makeSearchPath "lib/qt-6/qml" runtimeDeps;

  # Font configuration for ambxst
  fontconfig = makeFontsConf {
    fontDirectories = [
      material-symbols
      nerd-fonts.caskaydia-mono
      nerd-fonts.jetbrains-mono
    ];
  };

  # Prepare config files
  ambxstConfig =
    let
      inherit (lib.fileset) unions toSource fileFilter;
      root = configPath;
      isConfigFile =
        file:
        any file.hasExt [
          "qml"
          "js"
          "conf"
          "json"
          "css"
          "png"
          "svg"
          "jpg"
        ];
    in
    if builtins.pathExists root then
      toSource {
        inherit root;
        fileset = unions [
          (fileFilter isConfigFile root)
          (root + /assets)
          (root + /scripts)
          (root + /modules)
          (root + /config)
        ];
      }
    else
      builtins.throw "AmbXst config path does not exist: ${root}";

  # Build the configuration derivation
  qsConfig = stdenvNoCC.mkDerivation {
    name = "ambxst-config";
    src = ambxstConfig;

    installPhase = ''
      runHook preInstall
      mkdir -p $out
      cp -r . $out/
    '';

    preInstall = optionalString asGreeter ''
      if [ -f $out/greeter.qml ]; then
        rm -f $out/shell.qml
        cp $out/greeter.qml $out/shell.qml
      fi
    '';
  };

in
symlinkJoin {
  name = "ambxst";
  paths = runtimeDeps;

  nativeBuildInputs = [ makeWrapper ];

  postBuild = ''
    makeWrapper ${quickshell}/bin/quickshell $out/bin/ambxst \
      --set FONTCONFIG_FILE "${fontconfig}" \
      --set QML2_IMPORT_PATH "${qmlPath}" \
      ${lib.optionalString (customColors != null) "--set AMBXST_COLORS ${customColors}"} \
      --add-flags "-p ${qsConfig}" \
      --prefix PATH : "$out/bin"
  '';

  meta = {
    description = "Ambxst - An Axtremely customizable shell";
    homepage = "https://github.com/kagurazakei/Ambxst";
    license = lib.licenses.agpl3Only;
    mainProgram = "ambxst";
    platforms = lib.platforms.linux;
  };

  passthru = {
    inherit qsConfig;
    qmlPath = qmlPath;
  };
}
