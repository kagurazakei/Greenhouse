{ inputs, ... }:
{
  modules.programs.impermanence = {
    imports = [
      (inputs.impermanence + "/nixos.nix")
    ];
    environment.persistence."/persistent" = {
      enable = true; # NB: Defaults to true, not needed
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
        {
          directory = "/var/lib/colord";
          user = "colord";
          group = "colord";
          mode = "u=rwx,g=rx,o=";
        }
        "/var/lib/agenix"
      ];
      files = [
        ".screenrc"
        "/etc/sops-nix/keys.txt"
        "/etc/sops-nix/id_ed25519"
        {
          file = "/var/keys/secret_file";
          parentDirectory = {
            mode = "u=rwx,g=,o=";
          };
        }
      ];
    };
  };
}
