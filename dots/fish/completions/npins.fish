# npins.fish - Fish shell completions for npins

# Main command completions
complete -c npins -f

# Global options
complete -c npins -s d -l directory -r -d "Base folder for sources.json and boilerplate default.nix [env: NPINS_DIRECTORY=] [default: npins]"
complete -c npins -l lock-file -r -d "Specifies the path to sources.json and activates lockfile mode"
complete -c npins -s v -l verbose -d "Print debug messages"
complete -c npins -s h -l help -d "Print help"
complete -c npins -s V -l version -d "Print version"

# Subcommands
set -l commands init add show update verify upgrade remove import-niv import-flake freeze unfreeze get-path help
complete -c npins -n "not __fish_seen_subcommand_from $commands" -a init -d "Initialize the npins directory"
complete -c npins -n "not __fish_seen_subcommand_from $commands" -a add -d "Add a new pin entry"
complete -c npins -n "not __fish_seen_subcommand_from $commands" -a show -d "List the current pin entries"
complete -c npins -n "not __fish_seen_subcommand_from $commands" -a update -d "Update all or given pins to latest version"
complete -c npins -n "not __fish_seen_subcommand_from $commands" -a verify -d "Verify all or given pins still have correct hashes"
complete -c npins -n "not __fish_seen_subcommand_from $commands" -a upgrade -d "Upgrade sources.json and default.nix to latest format"
complete -c npins -n "not __fish_seen_subcommand_from $commands" -a remove -d "Remove a pin entry"
complete -c npins -n "not __fish_seen_subcommand_from $commands" -a import-niv -d "Import entries from Niv"
complete -c npins -n "not __fish_seen_subcommand_from $commands" -a import-flake -d "Import entries from flake.lock"
complete -c npins -n "not __fish_seen_subcommand_from $commands" -a freeze -d "Freeze a pin entry"
complete -c npins -n "not __fish_seen_subcommand_from $commands" -a unfreeze -d "Thaw a pin entry"
complete -c npins -n "not __fish_seen_subcommand_from $commands" -a get-path -d "Evaluate store path to a pin"
complete -c npins -n "not __fish_seen_subcommand_from $commands" -a help -d "Print help for subcommands"

# init subcommand
complete -c npins -n "__fish_seen_subcommand_from init" -l bare -d "Don't add initial nixpkgs entry"
complete -c npins -n "__fish_seen_subcommand_from init" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from init" -s h -l help -d "Print help"

# add subcommand
complete -c npins -n "__fish_seen_subcommand_from add" -l name -r -d "Add pin with custom name"
complete -c npins -n "__fish_seen_subcommand_from add" -l frozen -d "Add pin as frozen"
complete -c npins -n "__fish_seen_subcommand_from add" -s n -l dry-run -d "Don't actually apply changes"
complete -c npins -n "__fish_seen_subcommand_from add" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from add" -s h -l help -d "Print help"

# add subcommands
set -l add_commands channel github forgejo gitlab git pypi container tarball help
complete -c npins -n "__fish_seen_subcommand_from add; and not __fish_seen_subcommand_from $add_commands" -a channel -d "Track a Nix channel"
complete -c npins -n "__fish_seen_subcommand_from add; and not __fish_seen_subcommand_from $add_commands" -a github -d "Track a GitHub repository"
complete -c npins -n "__fish_seen_subcommand_from add; and not __fish_seen_subcommand_from $add_commands" -a forgejo -d "Track a Forgejo repository"
complete -c npins -n "__fish_seen_subcommand_from add; and not __fish_seen_subcommand_from $add_commands" -a gitlab -d "Track a GitLab repository"
complete -c npins -n "__fish_seen_subcommand_from add; and not __fish_seen_subcommand_from $add_commands" -a git -d "Track a git repository"
complete -c npins -n "__fish_seen_subcommand_from add; and not __fish_seen_subcommand_from $add_commands" -a pypi -d "Track a package on PyPi"
complete -c npins -n "__fish_seen_subcommand_from add; and not __fish_seen_subcommand_from $add_commands" -a container -d "Track an OCI container"
complete -c npins -n "__fish_seen_subcommand_from add; and not __fish_seen_subcommand_from $add_commands" -a tarball -d "Track a tarball"
complete -c npins -n "__fish_seen_subcommand_from add; and not __fish_seen_subcommand_from $add_commands" -a help -d "Print help for add subcommands"

# add channel subcommand
complete -c npins -n "__fish_seen_subcommand_from channel" -l name -r -d "Add pin with custom name"
complete -c npins -n "__fish_seen_subcommand_from channel" -l frozen -d "Add pin as frozen"
complete -c npins -n "__fish_seen_subcommand_from channel" -s n -l dry-run -d "Don't actually apply changes"
complete -c npins -n "__fish_seen_subcommand_from channel" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from channel" -l channel -r -d "Nix channel name"
complete -c npins -n "__fish_seen_subcommand_from channel" -l at -r -d "Use a specific commit instead of latest"
complete -c npins -n "__fish_seen_subcommand_from channel" -s h -l help -d "Print help"

# add github subcommand
complete -c npins -n "__fish_seen_subcommand_from github" -l name -r -d "Add pin with custom name"
complete -c npins -n "__fish_seen_subcommand_from github" -l frozen -d "Add pin as frozen"
complete -c npins -n "__fish_seen_subcommand_from github" -s n -l dry-run -d "Don't actually apply changes"
complete -c npins -n "__fish_seen_subcommand_from github" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from github" -l owner -r -d "GitHub owner/organization"
complete -c npins -n "__fish_seen_subcommand_from github" -l repo -r -d "GitHub repository name"
complete -c npins -n "__fish_seen_subcommand_from github" -s b -l branch -r -d "Track a branch instead of a release"
complete -c npins -n "__fish_seen_subcommand_from github" -l at -r -d "Use a specific commit/release instead of latest"
complete -c npins -n "__fish_seen_subcommand_from github" -l pre-releases -d "Also track pre-releases"
complete -c npins -n "__fish_seen_subcommand_from github" -l upper-bound -r -d "Bound version resolution"
complete -c npins -n "__fish_seen_subcommand_from github" -l release-prefix -r -d "Optional prefix required for each release name/tag"
complete -c npins -n "__fish_seen_subcommand_from github" -l submodules -d "Also fetch submodules"
complete -c npins -n "__fish_seen_subcommand_from github" -s h -l help -d "Print help"

# add forgejo subcommand
complete -c npins -n "__fish_seen_subcommand_from forgejo" -l name -r -d "Add pin with custom name"
complete -c npins -n "__fish_seen_subcommand_from forgejo" -l frozen -d "Add pin as frozen"
complete -c npins -n "__fish_seen_subcommand_from forgejo" -s n -l dry-run -d "Don't actually apply changes"
complete -c npins -n "__fish_seen_subcommand_from forgejo" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from forgejo" -l host -r -d "Forgejo host (e.g., forgejo.org)"
complete -c npins -n "__fish_seen_subcommand_from forgejo" -l owner -r -d "Repository owner"
complete -c npins -n "__fish_seen_subcommand_from forgejo" -l repo -r -d "Repository name"
complete -c npins -n "__fish_seen_subcommand_from forgejo" -s b -l branch -r -d "Track a branch instead of a release"
complete -c npins -n "__fish_seen_subcommand_from forgejo" -l at -r -d "Use a specific commit/release instead of latest"
complete -c npins -n "__fish_seen_subcommand_from forgejo" -l pre-releases -d "Also track pre-releases"
complete -c npins -n "__fish_seen_subcommand_from forgejo" -l upper-bound -r -d "Bound version resolution"
complete -c npins -n "__fish_seen_subcommand_from forgejo" -l release-prefix -r -d "Optional prefix required for each release name/tag"
complete -c npins -n "__fish_seen_subcommand_from forgejo" -l submodules -d "Also fetch submodules"
complete -c npins -n "__fish_seen_subcommand_from forgejo" -s h -l help -d "Print help"

# add gitlab subcommand
complete -c npins -n "__fish_seen_subcommand_from gitlab" -l name -r -d "Add pin with custom name"
complete -c npins -n "__fish_seen_subcommand_from gitlab" -l frozen -d "Add pin as frozen"
complete -c npins -n "__fish_seen_subcommand_from gitlab" -s n -l dry-run -d "Don't actually apply changes"
complete -c npins -n "__fish_seen_subcommand_from gitlab" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from gitlab" -l host -r -d "GitLab host (default: gitlab.com)"
complete -c npins -n "__fish_seen_subcommand_from gitlab" -l owner -r -d "Repository owner"
complete -c npins -n "__fish_seen_subcommand_from gitlab" -l repo -r -d "Repository name"
complete -c npins -n "__fish_seen_subcommand_from gitlab" -s b -l branch -r -d "Track a branch instead of a release"
complete -c npins -n "__fish_seen_subcommand_from gitlab" -l at -r -d "Use a specific commit/release instead of latest"
complete -c npins -n "__fish_seen_subcommand_from gitlab" -l pre-releases -d "Also track pre-releases"
complete -c npins -n "__fish_seen_subcommand_from gitlab" -l upper-bound -r -d "Bound version resolution"
complete -c npins -n "__fish_seen_subcommand_from gitlab" -l release-prefix -r -d "Optional prefix required for each release name/tag"
complete -c npins -n "__fish_seen_subcommand_from gitlab" -l submodules -d "Also fetch submodules"
complete -c npins -n "__fish_seen_subcommand_from gitlab" -s h -l help -d "Print help"

# add git subcommand
complete -c npins -n "__fish_seen_subcommand_from git" -l name -r -d "Add pin with custom name"
complete -c npins -n "__fish_seen_subcommand_from git" -l frozen -d "Add pin as frozen"
complete -c npins -n "__fish_seen_subcommand_from git" -s n -l dry-run -d "Don't actually apply changes"
complete -c npins -n "__fish_seen_subcommand_from git" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from git" -l forge -r -d "Forge type" -a "none auto gitlab github forgejo"
complete -c npins -n "__fish_seen_subcommand_from git" -s b -l branch -r -d "Track a branch instead of a release"
complete -c npins -n "__fish_seen_subcommand_from git" -l at -r -d "Use a specific commit/release instead of latest"
complete -c npins -n "__fish_seen_subcommand_from git" -l pre-releases -d "Also track pre-releases"
complete -c npins -n "__fish_seen_subcommand_from git" -l upper-bound -r -d "Bound version resolution"
complete -c npins -n "__fish_seen_subcommand_from git" -l release-prefix -r -d "Optional prefix required for each release name/tag"
complete -c npins -n "__fish_seen_subcommand_from git" -l submodules -d "Also fetch submodules"
complete -c npins -n "__fish_seen_subcommand_from git" -s h -l help -d "Print help"
complete -c npins -n "__fish_seen_subcommand_from git" -a "(__fish_npins_complete_urls)" -d "Git repository URL"

# add pypi subcommand
complete -c npins -n "__fish_seen_subcommand_from pypi" -l name -r -d "Add pin with custom name"
complete -c npins -n "__fish_seen_subcommand_from pypi" -l frozen -d "Add pin as frozen"
complete -c npins -n "__fish_seen_subcommand_from pypi" -s n -l dry-run -d "Don't actually apply changes"
complete -c npins -n "__fish_seen_subcommand_from pypi" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from pypi" -l package -r -d "PyPI package name"
complete -c npins -n "__fish_seen_subcommand_from pypi" -l version -r -d "Specific version to pin"
complete -c npins -n "__fish_seen_subcommand_from pypi" -l pre-releases -d "Also track pre-releases"
complete -c npins -n "__fish_seen_subcommand_from pypi" -l upper-bound -r -d "Bound version resolution"
complete -c npins -n "__fish_seen_subcommand_from pypi" -s h -l help -d "Print help"

# add container subcommand
complete -c npins -n "__fish_seen_subcommand_from container" -l name -r -d "Add pin with custom name"
complete -c npins -n "__fish_seen_subcommand_from container" -l frozen -d "Add pin as frozen"
complete -c npins -n "__fish_seen_subcommand_from container" -s n -l dry-run -d "Don't actually apply changes"
complete -c npins -n "__fish_seen_subcommand_from container" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from container" -l from -r -d "Container registry URL"
complete -c npins -n "__fish_seen_subcommand_from container" -l image -r -d "Container image name"
complete -c npins -n "__fish_seen_subcommand_from container" -l tag -r -d "Container image tag"
complete -c npins -n "__fish_seen_subcommand_from container" -l digest -r -d "Container image digest"
complete -c npins -n "__fish_seen_subcommand_from container" -s h -l help -d "Print help"

# add tarball subcommand
complete -c npins -n "__fish_seen_subcommand_from tarball" -l name -r -d "Add pin with custom name"
complete -c npins -n "__fish_seen_subcommand_from tarball" -l frozen -d "Add pin as frozen"
complete -c npins -n "__fish_seen_subcommand_from tarball" -s n -l dry-run -d "Don't actually apply changes"
complete -c npins -n "__fish_seen_subcommand_from tarball" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from tarball" -l url -r -d "Tarball URL"
complete -c npins -n "__fish_seen_subcommand_from tarball" -s h -l help -d "Print help"
complete -c npins -n "__fish_seen_subcommand_from tarball" -a "(__fish_npins_complete_urls)" -d "Tarball URL"

# show subcommand
complete -c npins -n "__fish_seen_subcommand_from show" -l json -d "Output in JSON format"
complete -c npins -n "__fish_seen_subcommand_from show" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from show" -s h -l help -d "Print help"

# update subcommand
complete -c npins -n "__fish_seen_subcommand_from update" -l partial -d "Only update pins that can be upgraded without breaking evaluation"
complete -c npins -n "__fish_seen_subcommand_from update" -l dry-run -d "Show what would be updated without actually updating"
complete -c npins -n "__fish_seen_subcommand_from update" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from update" -s h -l help -d "Print help"
complete -c npins -n "__fish_seen_subcommand_from update; and not __fish_seen_argument --all" -a "(__fish_npins_list_pins)" -d "Pin name to update"
complete -c npins -n "__fish_seen_subcommand_from update" -l all -d "Update all pins"

# verify subcommand
complete -c npins -n "__fish_seen_subcommand_from verify" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from verify" -s h -l help -d "Print help"
complete -c npins -n "__fish_seen_subcommand_from verify" -a "(__fish_npins_list_pins)" -d "Pin name to verify"

# upgrade subcommand
complete -c npins -n "__fish_seen_subcommand_from upgrade" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from upgrade" -s h -l help -d "Print help"

# remove subcommand
complete -c npins -n "__fish_seen_subcommand_from remove" -l dry-run -d "Show what would be removed without actually removing"
complete -c npins -n "__fish_seen_subcommand_from remove" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from remove" -s h -l help -d "Print help"
complete -c npins -n "__fish_seen_subcommand_from remove" -a "(__fish_npins_list_pins)" -d "Pin name to remove"

# import-niv subcommand
complete -c npins -n "__fish_seen_subcommand_from import-niv" -s n -l name -r -d "Only import one entry from Niv"
complete -c npins -n "__fish_seen_subcommand_from import-niv" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from import-niv" -s h -l help -d "Print help"
complete -c npins -n "__fish_seen_subcommand_from import-niv" -a "(__fish_npins_complete_files)" -d "Path to sources.json"

# import-flake subcommand
complete -c npins -n "__fish_seen_subcommand_from import-flake" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from import-flake" -s h -l help -d "Print help"
complete -c npins -n "__fish_seen_subcommand_from import-flake" -a "(__fish_npins_complete_files)" -d "Path to flake.lock"

# freeze subcommand
complete -c npins -n "__fish_seen_subcommand_from freeze" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from freeze" -s h -l help -d "Print help"
complete -c npins -n "__fish_seen_subcommand_from freeze" -a "(__fish_npins_list_pins)" -d "Pin name to freeze"

# unfreeze subcommand
complete -c npins -n "__fish_seen_subcommand_from unfreeze" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from unfreeze" -s h -l help -d "Print help"
complete -c npins -n "__fish_seen_subcommand_from unfreeze" -a "(__fish_npins_list_pins)" -d "Pin name to unfreeze"

# get-path subcommand
complete -c npins -n "__fish_seen_subcommand_from get-path" -s v -l verbose -d "Print debug messages"
complete -c npins -n "__fish_seen_subcommand_from get-path" -s h -l help -d "Print help"
complete -c npins -n "__fish_seen_subcommand_from get-path" -a "(__fish_npins_list_pins)" -d "Pin name to get path for"

# help subcommand
complete -c npins -n "__fish_seen_subcommand_from help" -a "$commands" -d "Show help for subcommand"

# Helper functions
function __fish_npins_list_pins
    # Try to read from sources.json first (lockfile mode)
    if test -f sources.json
        jq -r 'keys[]' sources.json 2>/dev/null
    else if test -f npins/sources.json
        jq -r 'keys[]' npins/sources.json 2>/dev/null
    else if test -f npins/default.nix
        # Fallback to parsing default.nix
        grep -E '^  [a-zA-Z0-9_-]+\.' npins/default.nix 2>/dev/null | string replace -r '^  ([a-zA-Z0-9_-]+)\..*$' '$1' | sort -u
    end
end

function __fish_npins_complete_urls
    # Suggest common URL patterns
    echo -e "https://\ngit@\nssh://\ngit://\nfile://"
end

function __fish_npins_complete_files
    # Complete JSON files
    ls *.json 2>/dev/null
end

function __fish_seen_subcommand_from
    set -l cmd (commandline -opc)
    for subcommand in $argv
        if contains -- $subcommand $cmd[2..-1]
            return 0
        end
    end
    return 1
end

function __fish_seen_argument
    set -l cmd (commandline -opc)
    for arg in $argv
        if contains -- $arg $cmd
            return 0
        end
    end
    return 1
end
