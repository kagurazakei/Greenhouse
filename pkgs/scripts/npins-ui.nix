{ pkgs }:
let
  script = pkgs.writeShellScriptBin "npins-ui" ''
    #!/usr/bin/env bash
    PATH=${pkgs.coreutils}/bin:${pkgs.gnused}/bin:${pkgs.fzf}/bin:${pkgs.npins}/bin:$PATH

    resolve_file() {
      case "$1" in
        start)
          echo "${NPINS_FILE_START: -start-plugins.json}"
          ;;
        opt)
          echo "${NPINS_FILE_OPT: -opt-plugins.json}"
          ;;
        sources)
          echo "${NPINS_FILE_SOURCES: -npins/sources.json}"
          ;;
        *)
          echo "$1" | sed "s|^~|$HOME|"
          ;;
      esac
    }

    MODE="${"1:-sources"}"
    FILE=$(resolve_file "$MODE")

    if [ ! -f "$FILE" ]; then
      echo "❌ File not found: $FILE"
      exit 1
    fi

    parse() {
      npins --lock-file "$FILE" show | awk '
        BEGIN {
          pin=""; type="unknown"; repo="unknown"; rev="unknown";
        }

        /^[a-zA-Z0-9._-]+:/ {
          split($1, a, ":")
          pin=a[1]
          type="unknown"
          repo="unknown"
          rev="unknown"
        }

        /^[[:space:]]*type:/ { type=$2 }

        /^[[:space:]]*repository:/ {
          repo=substr($0, index($0, ":") + 2)
        }

        /^[[:space:]]*revision:/ { rev=$2 }

        /^[[:space:]]*frozen:/ {
          printf "%s|%s|%s|%s\n", pin, type, repo, rev
        }
      '
    }

    parse | fzf \
      --ansi \
      --layout=reverse \
      --border \
      --header="📦 NPins UI | file: $FILE" \
      --preview '
        line={}
        pin=$(echo "$line" | cut -d"|" -f1)
        type=$(echo "$line" | cut -d"|" -f2)
        repo=$(echo "$line" | cut -d"|" -f3)
        rev=$(echo "$line" | cut -d"|" -f4)

        echo "📦 PIN: $pin"
        echo "🔧 TYPE: $type"
        echo "🌐 REPO: $repo"
        echo "🔖 REV: $rev"
      ' \
      --bind "enter:execute-silent(echo "$(echo {} | cut -d"|" -f4)" | wl-copy)+abort" \
      --bind "ctrl-o:execute-silent(xdg-open https://github.com/$(echo {} | cut -d"|" -f3))"
  '';
in
pkgs.symlinkJoin {
  name = "npins-ui";
  paths = [ script ];
}
