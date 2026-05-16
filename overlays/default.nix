{
  inputs ? import ../npins,
}:
[
  (_final: prev: {
    inherit (prev.stdenv.hostPlatform) system;
    master = import inputs.master {
      inherit (prev.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
    stable = import inputs.stable {
      inherit (prev.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
  })
  inputs.niri-nix.overlays.niri-nix
  inputs.nix-cachyos-kernel.overlays.pinned
]
