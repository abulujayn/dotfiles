#!/usr/bin/env bash
set -euo pipefail

config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/noctalia"
output="$config_dir/90-idle-power.toml"
tmp="${output}.tmp"

on_ac_power() {
    local supply type online

    for supply in /sys/class/power_supply/*; do
        [[ -r "$supply/type" && -r "$supply/online" ]] || continue

        type=$(<"$supply/type")
        online=$(<"$supply/online")

        case "$type" in
            Mains|USB|USB_C|USB_PD)
                [[ "$online" == "1" ]] && return 0
                ;;
        esac
    done

    return 1
}

if on_ac_power; then
    lock_timeout=900          # 15 min
    screen_timeout=1200       # 20 min
    suspend_enabled=false
else
    # Battery
    lock_timeout=300          # 5 min
    screen_timeout=600        # 5 min
    suspend_enabled=true
fi
locked_screen_timeout=20      # 20 sec
suspend_timeout=1200          # 20 min

cat > "$tmp" <<EOF
[idle.behavior.lock]
enabled = true
action = "lock"
timeout = $lock_timeout

[idle.behavior.screen-off]
enabled = true
action = "screen_off"
timeout = $screen_timeout
locked_timeout = $locked_screen_timeout

[idle.behavior.suspend]
enabled = $suspend_enabled
action = "lock_and_suspend"
timeout = $suspend_timeout
EOF

# Don't cause a config reload if nothing actually changed.
if [[ -f "$output" ]] && cmp -s "$tmp" "$output"; then
    rm "$tmp"
else
    mv "$tmp" "$output"
fi
