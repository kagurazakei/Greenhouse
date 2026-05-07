{ inputs, username, ... }:
{
  modules.nixos.misc_agenix =
    {
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        (inputs.agenix + "/modules/age.nix")
        (lib.mkAliasOptionModule [ "kagura" "secrets" ] [ "age" "secrets" ])
      ];
      environment.systemPackages = [
        (pkgs.callPackage "${inputs.agenix}/pkgs/agenix.nix" { })
      ];
      age.identityPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
        "/persistent/etc/sops-nix/id_ed25519"
        "/home/${username}/.ssh/id_ed25519"
      ]
      ++ builtins.map (username: "/home/${username}/.ssh/id_ed25519") [ username ];

    };
}
