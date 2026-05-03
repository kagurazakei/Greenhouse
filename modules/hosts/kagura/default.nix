{ self, ... }:
let
  hostname = "hana";
in
{
  modules.hosts.${hostname} = {
    imports = [
      self.modules.nixos.misc_steam

      self.modules.nixos.trash
      self.modules.nixos.audio
      self.modules.nixos.bluetooth
      self.modules.nixos.bootloader
      self.modules.nixos.env
      self.modules.nixos.fonts
      self.modules.nixos.locale
      self.modules.nixos.networking
      self.modules.nixos.nix
      self.modules.nixos.packages
      self.modules.nixos.virtualisation
      self.modules.nixos.intel
      self.modules.nixos.nvidia
      self.modules.nixos.sysc-greet
      self.modules.nixos.ambxst
      self.modules.wm._
      self.modules.wm.hyprland
      self.modules.wm.niri

      self.modules.hjem._
      self.modules.hjem.vsmrf

      ./+hardware.nix
    ];
    nixos = {
      graphics.intel.hwAccelDriver = "media-driver";
      graphics.nvidia = {
        hybrid = {
          enable = true;
          igpu.vendor = "intel";
          igpu.port = "PCI:0:2:0";
          dgpu.port = "PCI:1:0:0";
        };
      };
    };
    networking.hostName = hostname;
    system.stateVersion = "26.05";
  };
}
