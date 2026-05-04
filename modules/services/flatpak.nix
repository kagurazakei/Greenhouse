{ inputs, ... }:
{
  modules.nixos.services_flatpak = {
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
  };
}
