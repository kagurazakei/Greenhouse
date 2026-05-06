# Host configurations
set -g hosts \
    "kagura:192.168.100.31" \
    "hana:192.168.100.29"

# Main deploy function
function deploy
    set host $argv[1]
    set ip $argv[2]

    # If IP not provided, look it up
    if test -z "$ip"
        for h in $hosts
            set hname (string split ":" $h)[1]
            set hip (string split ":" $h)[2]
            if test "$hname" = "$host"
                set ip $hip
                break
            end
        end
    end

    if test -z "$ip"
        # Build list of available hosts
        set available_hosts ""
        for h in $hosts
            set hname (string split ":" $h)[1]
            set available_hosts "$available_hosts $hname"
        end
        echo "Unknown host: $host"
        echo "Available: $available_hosts"
        return 1
    end

    echo "🚀 Deploying to $host ($ip)..."
    nixos-rebuild boot --flake .#$host --target-host antonio@$ip --sudo
end

# Create shortcut aliases for each host
for h in $hosts
    set hname (string split ":" $h)[1]
    eval "function d-$hname; deploy $hname; end"
end

# Also create aliases without the 'd-' prefix
for h in $hosts
    set hname (string split ":" $h)[1]
    eval "function $hname-deploy; deploy $hname; end"
end
