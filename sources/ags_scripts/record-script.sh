#!/usr/bin/env bash

getdate() {
    date '+%Y-%m-%d_%H.%M.%S'
}
getaudiooutput() {
    pactl list sources | grep 'Name' | grep 'monitor' | cut -d ' ' -f2
}
getactivemonitor() {
    hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name'
}

mkdir -p "$(xdg-user-dir VIDEOS)"
cd "$(xdg-user-dir VIDEOS)" || exit

mkdir -p "ScreenCaptures"
cd "ScreenCaptures" || exit


runSlurp=$HOME/.config/slurp/run.sh
slurpinprogressfile="$HOME/.config/slurp/.SLURP_IN_PROGRESS"
inprogressfile=".RECORDING_IN_PROGRESS"

if [ -f $inprogressfile ] || [ -f $slurpinprogressfile ] || [ pgrep wf-recorder > /dev/null ]; then
    # same as just running slurpxstop
    rm -rf $slurpinprogressfile
    pkill slurp
    
    if [ -f $inprogressfile ]; then
      rm -rf $inprogressfile
      
      notify-send "Recording Stopped" "Stopped" -a 'record-script.sh' &
      pkill wf-recorder &
    fi
else
    touch $inprogressfile
    #notify-send "Starting recording" 'recording_'"$(getdate)"'.mp4' -a 'record-script.sh'
    if [[ "$1" == "--sound" ]]; then
      notify-send "Starting recording (w/ audio)" 'recording_'"$(getdate)"'.mp4' -a 'record-script.sh'
      wf-recorder --pixel-format yuv420p -f './recording_'"$(getdate)"'.mp4' -t --geometry "$($runSlurp)" --audio="$(getaudiooutput)" & disown
    elif [[ "$1" == "--fullscreen-sound" ]]; then
      notify-send "Starting fullscreen recording (w/ audio)" 'recording_'"$(getdate)"'.mp4' -a 'record-script.sh'
      wf-recorder -o $(getactivemonitor) --pixel-format yuv420p -f './recording_'"$(getdate)"'.mp4' -t --audio="$(getaudiooutput)" & disown
    elif [[ "$1" == "--fullscreen" ]]; then
      notify-send "Starting fullscreen recording (no audio)" 'recording_'"$(getdate)"'.mp4' -a 'record-script.sh'
      wf-recorder -o $(getactivemonitor) --pixel-format yuv420p -f './recording_'"$(getdate)"'.mp4' -t & disown
    else
      notify-send "Starting recording (no audio)" 'recording_'"$(getdate)"'.mp4' -a 'record-script.sh'
      wf-recorder --pixel-format yuv420p -f './recording_'"$(getdate)"'.mp4' -t --geometry "$($runSlurp)" & disown
    fi
fi
