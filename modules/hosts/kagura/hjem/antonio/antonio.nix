{
  self,
  inputs,
  utils,
  ...
}:
let
  username = "antonio";
  dots = "${./_config}";
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
          colorScheme = ./_config/theme/BreezeDark.colors;
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

      hjem.users.${username} = {
        clobberFiles = true;
        impure = {
          enable = true;
          dotsDir = dots;
          dotsDirImpure = "/home/antonio/Greenhouse/modules/hosts/kagura/hjem/antonio/_config";
        };
        packages = import ./_packages.nix { inherit inputs pkgs; };
        xdg.config.files = {
          "nixpkgs".source = ./_config/nixpkgs;
          "mpv/mpv.conf".source = ./_config/mpv/mpv.conf;
          "ghostty".source = utils.mkStoreSymlink ./_config/ghostty;
          "fastfetch".source = dots + "/fastfetch";
          "git".source = ./_config/git;
          "swappy/config".source = ./_config/swappy/config;
          "lazygit".source = dots + "/lazygit";
          "bottom".source = ./_config/bottom;
          "btop".source = utils.mkStoreSymlink ./_config/btop;
          "kitty/kitty.conf".source = ./_config/kitty/kagura.conf;
          "kitty/themes/oxocarbon.conf".source = ./_config/kitty/themes/oxocarbon.conf;
          "carapace/carapace.toml".source = ./_config/carapace/carapace.toml;
          "equibop/settings.json".source = dots + "/equibop/settings.json";
          "equibop/themes".source = dots + "/equibop/themes";
          "applications.menu".source = dots + "/menus/applications.menu";
          "fuzzel/fuzzel.ini".source = dots + "/fuzzel/fuzzel.ini";
          "fuzzel/noctalia".source = dots + "/fuzzel/noctalia";
          "foot/foot.ini".source = dots + "/foot/foot.ini";
          "foot/rose-pine.ini".source = inputs.rosep-foot + "/rose-pine";
        };
      };
    };
}
