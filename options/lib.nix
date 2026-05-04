{
  config,
  pkgs,
  lib,
  ...
}: # Add 'lib' here

let
  sources = import ../npins;

  mkDotsModule =
    username: dots:
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      dotsDir = config.hjem.users.${username}.impure.dotsDir or "/home/${username}/dotfiles";

      processPath =
        path:
        if builtins.isFunction path then
          path {
            inherit lib config;
            dotsDir = dotsDir;
            sources = sources;
          }
        else
          dotsDir + path;

      mkSource = path: { source = processPath path; };
    in
    {
      hjem.users.${username}.xdg.config.files = lib.mapAttrs (_: path: mkSource path) dots;
    };
in
{
  _module.args = {
    inherit mkDotsModule;
  };
}
