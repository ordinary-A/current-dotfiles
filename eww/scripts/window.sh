#!/bin/bash

get_title() {
    title=$(hyprctl activewindow -j 2>/dev/null | jq -r '.title // "Desktop"')
    if [ ${#title} -gt 50 ]; then
        title="${title:0:50}..."
    fi
    echo "$title"
}

get_title

socat -u UNIX-CONNECT:/run/user/1000/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
    event=$(echo "$line" | cut -d'>' -f1)
    if [[ "$event" == "activewindow" ]] || [[ "$event" == "closewindow" ]] || [[ "$event" == "workspace" ]]; then
        get_title
    fi
done
