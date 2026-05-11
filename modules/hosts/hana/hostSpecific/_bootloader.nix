{ inputs, ... }:
{
  modules.hosts.hana =
    { pkgs, ... }:
    {
      boot = {
        consoleLogLevel = 0;
        loader.timeout = 0;
        plymouth = {
          enable = true;
          themePackages = [
            (pkgs.callPackage "${inputs.shizuruPkgs}/pkgs/default.nix" { }).cat-plymouth
          ];
          theme = "catppuccin-mocha-mod";
        };
      };
      environment.systemPackages = [
        (pkgs.callPackage (inputs.shizuruPkgs + "/pkgs/default.nix") { }).kureiji-ollie-cursors
      ];
    };
}
