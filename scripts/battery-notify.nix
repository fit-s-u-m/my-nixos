{ pkgs }:

pkgs.writeShellScriptBin "battery-notify" ''

battery_full_threshold=100        # Full battery threshold
battery_critical_threshold=5      # Critical battery threshold
battery_low_threshold=20          # Low battery threshold
unplug_charger_threshold=80       # Threshold to unplug the charger
notify_interval=5                 # Notification interval in minutes
timer=120                         
verbose=false                     # Enable verbose logging (set to true for debugging)

# Global variables
battery_status=""
battery_percentage=0
last_battery_status=""
last_battery_percentage=0

# Get battery information using upower or sysfs (fallback method)
get_battery_info() {
  battery_status=$(upower -i $(upower -e | grep 'battery') | grep -i state | awk '{print $2}')
  battery_percentage=$(upower -i $(upower -e | grep 'battery') | grep -i percentage | awk '{print $2}' | tr -d '%')

  # If upower is not available, fallback to sysfs method
  if [[ -z "$battery_status" || -z "$battery_percentage" ]]; then
    total_percentage=0
    battery_count=0
    for battery in /sys/class/power_supply/BAT*; do
      if [[ -f "$battery/status" && -f "$battery/capacity" ]]; then
        battery_status=$(<"$battery/status")
        battery_percentage=$(<"$battery/capacity")
        total_percentage=$((total_percentage + battery_percentage))
        battery_count=$((battery_count + 1))
      fi
    done
    if [[ $battery_count -gt 0 ]]; then
      battery_percentage=$((total_percentage / battery_count))  # Average percentage for multiple batteries
    else
      echo "No battery detected."
      exit 1
    fi
  fi
}

# Send notification using notify-send
send_notification() {
  local title=$1
  local message=$2
  notify-send -a "Battery Monitor" -u critical "$title" "$message"
}

# Handle battery status change and trigger actions
fn_status_change() {
  get_battery_info
  if [[ "$battery_status" != "$last_battery_status" || "$battery_percentage" != "$last_battery_percentage" ]]; then
    last_battery_status="$battery_status"
    last_battery_percentage="$battery_percentage"

    if [[ "$verbose" == true ]]; then
      echo "Battery status changed: $battery_status"
      echo "Battery percentage: $battery_percentage"
    fi

    # Check battery conditions and trigger appropriate actions
    if [[ $battery_percentage -le $battery_low_threshold && "$battery_status" == "Discharging" ]]; then
      send_notification "Battery Low" "Battery is at $battery_percentage%. Please connect the charger."
    fi

    if [[ $battery_percentage -le $battery_critical_threshold && "$battery_status" == "Discharging" ]]; then
      send_notification "Battery Critical" "Battery is at $battery_percentage%. System will suspend in $((timer / 60)) minutes."
      sleep "$timer"
      systemctl suspend
    fi

    if [[ $battery_percentage -ge $unplug_charger_threshold && "$battery_status" != "Discharging" ]]; then
      send_notification "Battery Charged" "Battery is at $battery_percentage%. You can unplug the charger."
    fi
  fi
}

# Main function to monitor the battery status continuously
main() {
  while true; do
    fn_status_change
    sleep $((notify_interval * 60))  # Check every $notify_interval minutes
  done
}

# Start monitoring
main

''
