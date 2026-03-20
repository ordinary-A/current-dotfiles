#!/bin/bash

get_vol() {
    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
    muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -c MUTED)
    if [ "$muted" -gt 0 ]; then
        /usr/bin/eww update volico="󰖁"
        vol="0"
    else
        /usr/bin/eww update volico="󰕾"
    fi
    /usr/bin/eww update get_vol="$vol"
}

get_vol

while true; do
    sleep 1
    get_vol
done
