#!/bin/bash

get_workspaces() {
    active=$(hyprctl activeworkspace -j | jq '.id')
    workspaces=$(hyprctl workspaces -j | jq '[.[].id] | sort')
    
    result="["
    for i in 1 2 3 4 5; do
        exists=$(echo "$workspaces" | jq "contains([$i])")
        if [ "$i" == "$active" ]; then
            class="active"
        elif [ "$exists" == "true" ]; then
            class="occupied"
        else
            class="empty"
        fi
        result+="{\"id\":$i,\"class\":\"$class\"}"
        if [ $i -lt 5 ]; then
            result+=","
        fi
    done
    result+="]"
    echo "$result"
}

get_workspaces

socat -u UNIX-CONNECT:/run/user/1000/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
    event=$(echo "$line" | cut -d'>' -f1)
    if [[ "$event" == "workspace" ]] || [[ "$event" == "createworkspace" ]] || [[ "$event" == "destroyworkspace" ]] || [[ "$event" == "focusedmon" ]]; then
        get_workspaces
    fi
done
