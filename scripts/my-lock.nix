{ pkgs }:

pkgs.writeShellScriptBin "my-lock" ''

  if ! command -v swayidle &>/dev/null; then
      echo "swayidle is not installed. Installing..."
      exit 1
  else
      echo "swayidle is installed"
      swayidle -w timeout 300 "swaylock -f" timeout 300 "hyprctl dispatch dpms off" resume "hyprctl dispatch dpms on"
  fi
''
