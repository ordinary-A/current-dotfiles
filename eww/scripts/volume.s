#!/bin/bash

get_volume() {
    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
    muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -c MUTED)
    if [ "$muted" -gt 0 ]; then
        echo "󰝟 muted"
    else
        echo "󰕾 ${vol}%"
    fi
}

get_volume

while true; do
    sleep 1
    get_volume
done
