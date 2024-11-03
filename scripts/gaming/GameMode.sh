#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Game Mode. Turning off all animations and blur

#   ____                                          _      
#  / ___| __ _ _ __ ___   ___ _ __ ___   ___   __| | ___ 
# | |  _ / _` | '_ ` _ \ / _ \ '_ ` _ \ / _ \ / _` |/ _ \
# | |_| | (_| | | | | | |  __/ | | | | | (_) | (_| |  __/
#  \____|\__,_|_| |_| |_|\___|_| |_| |_|\___/ \__,_|\___|
#
#

notif="$HOME/.config/swaync/images/bell.png"
SCRIPTSDIR="$HOME/.local/share/scripts" # TODO: make this automatic

HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')

# Waybar performance
FILE="$HOME/.config/waybar/style.css"

sed -i 's/\/\* \(.*animation:.*\) \*\//\1/g' $FILE
sed -i 's/\/\* \(.*transition:.*\) \*\//\1/g' $FILE

if [ $HYPRGAMEMODE = 1 ]; then
	sed -i 's/^\(.*animation:.*\)$/\/\* \1 \*\//g' $FILE
	sed -i 's/^\(.*transition:.*\)$/\/\* \1 \*\//g' $FILE
fi
killall waybar
waybar >/dev/null 2>&1 &

if [ "$HYPRGAMEMODE" = 1 ] ; then
  hyprctl --batch "\
    keyword animations:enabled 0;\
    keyword decoration:drop_shadow 0;\
    keyword decoration:blur:passes 0;\
    keyword decoration:blur:enabled 0;\
    keyword general:gaps_in 0;\
    keyword general:gaps_out 0;\
    keyword general:border_size 1;\
    keyword decoration:rounding 0"
	touch ~/.cache/gamemode
	hyprctl keyword "windowrule opacity 1 override 1 override 1 override, ^(.*)$"
    swww kill
    notify-send -e -u low -i "$notif" "Game Mode enabled. All animations & blur off"
    exit
else
  rm ~/.cache/gamemode
	swww-daemon --format xrgb && swww img "$HOME/.config/rofi/.current_wallpaper" &
	sleep 0.1
	${SCRIPTSDIR}/WallustSwww.sh
	sleep 0.5
	${SCRIPTSDIR}/Refresh.sh	 
    notify-send -e -u normal -i "$notif" "Game Mode disabled. All animations & blur normal"
    exit
fi
hyprctl reload
