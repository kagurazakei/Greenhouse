let
  src = import ./npins;
  pkgs = import src.nixpkgs { };
in
pkgs.mkShell {
  NPINS_DIRECTORY = "npins";
  IMPURE = "true";

  buildInputs = [
    (pkgs.writeShellScriptBin "opt" ''
      npins --lock-file ./modules/hosts/kagura/hjem/antonio/_config/neovim/opt-plugins.json "$@"
    '')
    (pkgs.writeShellScriptBin "start" ''
      npins --lock-file ./modules/hosts/kagura/hjem/antonio/_config/neovim/start-plugins.json "$@"
    '')
    pkgs.npins
  ];

  shellHook = ''
    export NIX_PATH="nixpkgs=$(npins get-path nixpkgs)"
    echo "Dev shell ready. Available: opt, start, npins"
  '';
}
