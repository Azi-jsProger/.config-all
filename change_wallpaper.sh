#!/bin/bash
WALLPAPERS=("/path/to/wallpaper1.jpg" "/path/to/wallpaper2.jpg")
CURRENT=$(grep "wallpaper =" ~/.config/hypr/hyprpaper.conf | awk -F ',' '{print $2}')
NEXT_INDEX=0

for i in "${!WALLPAPERS[@]}"; do
    if [[ "${WALLPAPERS[$i]}" == "$CURRENT" ]]; then
        NEXT_INDEX=$(( (i + 1) % ${#WALLPAPERS[@]} ))
        break
    fi
done

sed -i "s|wallpaper = ,.*|wallpaper = ,${WALLPAPERS[$NEXT_INDEX]}|" ~/.config/hypr/hyprpaper.conf
hyprctl hyprpaper unload all
hyprctl hyprpaper preload "${WALLPAPERS[$NEXT_INDEX]}"
hyprctl hyprpaper wallpaper ",${WALLPAPERS[$NEXT_INDEX]}"
