{
  self,
  inputs,
  config,
  ...
}:
let
  username = "antonio";
  dots = "${self.paths.dots}";
  iconSource = dots + "/profile.png"; # Define once
in
{
  modules.hjem.${username} =
    { pkgs, lib, ... }:
    {
      nixpkgs.overlays = [
        inputs.neovim-nightly.overlays.default
      ];
      imports = [
        self.modules.hjem.theming
        (lib.mkAliasOptionModule [ "hj" ] [ "hjem" "users" "${username}" ])
        (lib.mkAliasOptionModule [ "impure-dots" ] [ "hjem" "users" "${username}" "impure" "dotsDir" ])
      ];
      theming = {
        inherit username;
        enable = true;
        qt = {
          colorScheme = self.paths.dots + "/theme/BreezeDark.colors";
          iconTheme = "Papirus-Dark";
        };
      };
      users.users.${username} = {
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "input"
          "wheel"
          "video"
          "render"
          "libvrtd"
        ];
        shell = pkgs.fish;

        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEaNh2GVxWz2zLxDa8cMnPtfYQPk1A3xlKKVuKOTNrp2 antonio@hana"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjywfRHVDeBQBFYZym/c3JDVRwni//tSy5FPKmTgLyN antonio@hana"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDT989Rm6vSVS4cSP2NevoXVS7UnFVYHgfsE6dbM2+s6 hana@antonio"
        ];
      };
      programs.fish.enable = true;
      programs.gpu-screen-recorder.enable = true;

      # Hjem dotfiles
      hj.files = {
        ".face.icon".source = iconSource;
      };

      # AccountsService configuration - FIXED: use iconSource directly
      systemd.tmpfiles.rules = [
        # AccountsService user file
        "f+ /var/lib/AccountsService/users/${username} 0600 root root - \
[User]\nIcon=/var/lib/AccountsService/icons/${username}\n"

        # Symlink icon - use iconSource directly, not config.hj
        "L+ /var/lib/AccountsService/icons/${username} - - - - ${iconSource}"
      ];

      hjem.users.${username} = {
        clobberFiles = true;
        impure = {
          enable = true;
          dotsDir = dots;
          dotsDirImpure = "/home/antonio/Greenhouse/dots";
        };
        packages = import ./_packages.nix { inherit inputs pkgs; };
        xdg.config.files = {
          "nixpkgs".source = dots + "/nixpkgs";
          "fastfetch".source = dots + "/fastfetch";
          "git".source = dots + "/git";
          "swappy/config".source = dots + "/swappy/config";
          "lazygit".source = dots + "/lazygit";
          "bottom".source = dots + "/bottom";
          "btop".source = dots + "/btop";
          "kitty/kitty.conf".source = dots + "/kitty/kagura.conf";
          "kitty/themes/oxocarbon.conf".source = dots + "/kitty/themes";
          "carapace/carapace.toml".source = dots + "/carapace/carapace.toml";
          "equibop/settings.json".source = dots + "/equibop/settings.json";
          "equibop/themes".source = dots + "/equibop/themes";
          "applications.menu".source = dots + "/menus/applications.menu";
          "fuzzel/fuzzel.ini".source = dots + "/fuzzel/fuzzel.ini";
          "fuzzel/noctalia".source = dots + "/fuzzel/noctalia";
          "foot/foot.ini".source = dots + "/foot/foot.ini";
          "foot/rose-pine.ini".source = inputs.rosep-foot + "/rose-pine";
          "wallpapers/nix-logo.png".source = inputs.walls + "/nix-logo.png";
          ".face.icon".source = iconSource;
        };
      };
    };
}
