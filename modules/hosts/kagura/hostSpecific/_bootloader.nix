{ inputs, ... }:
{
  modules.hosts.kagura =
    { pkgs, ... }:
    {
      boot = {
        consoleLogLevel = 0;
        loader.timeout = 0;
      };
      environment.systemPackages = [
        (pkgs.callPackage (inputs.shizuruPkgs + "/pkgs/default.nix") { }).kureiji-ollie-cursors
      ];
    };
}
