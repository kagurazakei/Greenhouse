{ pkgs }:
let
  betterShow = pkgs.writeShellScriptBin "betterShow" ''
    awk '
    BEGIN { print "PIN FROZEN REPOSITORY REVISION" }
    /^\w.*:/ { split($1, BUF, ":"); PIN=BUF[1]; REPO="UNKNOWN"; REVISION="UNKNOWN";}
    /repository: / { REPO=$2 }
    /revision:/ { REVISION=$2 }
    /frozen:/ { print PIN, $2, REPO, REVISION }
    '
  '';
in
pkgs.writeShellScriptBin "npins-show" ''
  cd ~/nixos
  ${pkgs.npins}/bin/npins show | ${betterShow}/bin/betterShow | ${pkgs.column}/bin/column -t
''
