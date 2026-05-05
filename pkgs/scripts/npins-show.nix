{ pkgs }:
pkgs.writeShellScriptBin "npins-show" ''
    #!/usr/bin/env bash
    ${pkgs.npins}/bin/npins show | awk '
  BEGIN { print "PIN FROZEN REPOSITORY REVISION" }
  /^\w.*:/ { split($1, BUF, ":"); PIN=BUF[1]; REPO="UNKNOWN"; REVISION="UNKNOWN"; }
  /repository: / { REPO=$2 }
  /revision:/ { REVISION=$2 }
  /frozen:/ { print PIN, $2, REPO, REVISION }
  ' | column -t
''
