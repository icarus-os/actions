import subprocess

# TODO: change to using notify-send rather than hyprctl notify

COLOR = "rgb(000000)"
VOLUME_MUTED_MSG = "🔇"
VOLUME_UNMUTED_MSG = "🔊"
TIME_MS: int = 2500

if __name__ == "__main__":
    volume = subprocess.run('pamixer -t && wpctl get-volume @DEFAULT_AUDIO_SINK@', shell=True, capture_output=True, text=True)
    
    msg: str = ""
    if "[MUTED]" in volume.stdout:
        msg = VOLUME_MUTED_MSG
    else:
        msg = VOLUME_UNMUTED_MSG

    subprocess.run(f'hyprctl notify -1 {TIME_MS} "{COLOR}" "fontsize:50  {msg}"', shell=True)
