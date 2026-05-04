let
  sources = import ../+npins;
  pkgs = import sources.nixpkgs { };

  # Check if a value is a function
  isFunction = f: builtins.isFunction f;
in
username: dots:
{
  config,
  lib,
  ...
}:
let
  # Get the base dotfiles directory from hjem config
  dotsDir = config.hjem.users.${username}.impure.dotsDir or "/home/${username}/dotfiles";

  # Arguments to pass to function-based sources
  args = {
    inherit lib config dotsDir;
  };

  # Normalize a single dotfile source
  normalize = dot: if isFunction dot then { source = dot args; } else { source = dotsDir + dot; };

in
{
  hjem.users.${username}.xdg.config.files = lib.mapAttrs (_: dot: normalize dot) dots;
}
