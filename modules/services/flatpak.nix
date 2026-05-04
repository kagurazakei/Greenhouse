{ inputs, ... }:
{
  modules.services.flatpak =
    { pkgs, ... }:
    {
      imports = [
        (inputs.nix-flatpak + "/modules/nixos.nix")
      ];
      services = {
        flatpak = {
          enable = true;
          packages = [
            "com.github.tchx84.Flatseal"
            "app.opencomic.OpenComic"
          ];
        };
      };
      hj = {
        systemd.services = {
          hjem-impure = {
            description = "Hjem Impure Systemd Service";
            after = [ "graphical-session.target" ];
            partOf = [ "graphical-session.target" ];
            serviceConfig = {
              ExecStart = "/etc/profiles/per-user/antonio/bin/hjem-impure";
              Restart = "on-failure";
            };
          };
          arrpc = {
            description = "arRPC Systemd Service";
            after = [ "graphical-session.target" ];
            partOf = [ "graphical-session.target" ];
            serviceConfig = {
              ExecStart = "${pkgs.arrpc}/bin/arrpc";
              Restart = "on-failure";
            };
          };
        };
      };
    };
}
