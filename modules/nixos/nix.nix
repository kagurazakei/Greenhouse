{
  modules.nixos.nix =
    { config, ... }:
    {
      documentation.enable = false;

      nixpkgs.config.allowUnfree = true;

      nix = {
        channel.enable = false;
        nixPath = [ "nixpkgs=/etc/nixos/nixpkgs" ];

        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
            "pipe-operators"
          ];
          auto-optimise-store = true;
          require-sigs = true;
          sandbox = true;
          sandbox-fallback = false;
          download-attempts = 3;
          show-trace = true;
          trusted-users = [
            "root"
            "antonio"
            "@wheel"
          ];
          allowed-users = [
            "@wheel"
            "antonio"
            "root"
          ];
          extra-substituters = [
            "https://nix-community.cachix.org"
            "https://cache.garnix.io"
            "https://loneros.cachix.org"
            "https://heitor.cachix.org"
            "https://niri-nix.cachix.org"
          ];
          extra-trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
            "loneros.cachix.org-1:dVCECfW25sOY3PBHGBUwmQYrhRRK2+p37fVtycnedDU="
            "heitor.cachix.org-1:IZ1ydLh73kFtdv+KfcsR4WGPkn+/I926nTGhk9O9AxI="
            "niri-nix.cachix.org-1:SvFtqpDcf7Sm1SMJdby1/+Y+6f3Yt3/3PMcSTKPJNJ0="
          ];
        };

        optimise = {
          automatic = true;
          persistent = true;
          dates = "weekly";
        };

        gc = {
          automatic = false;
          persistent = true;
          dates = "weekly";
          options = "--delete-older-than 30d";
        };

        extraOptions = ''
          allow-import-from-derivation = false
          !include ${config.age.secrets.secret2.path}
          connect-timeout = 60
          require-sigs = false
        '';
      };
    };
}
