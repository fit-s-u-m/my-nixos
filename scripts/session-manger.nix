{ pkgs }:

pkgs.writeShellScriptBin "session-manager" ''
    # Check if an argument is provided
    if [ -z "$1" ]; then
        # ZOXIDE_RESULT =$(zoxide query -i)
        ZOXIDE_RESULT=$(zoxide query --list | rofi -dmenu)
    else
        # Query zoxide for the path
        ZOXIDE_RESULT=$(zoxide query "$1")
    fi

    # Check if zoxide returned a result
    if [ -z "$ZOXIDE_RESULT" ]; then
        exit 0
    fi

    # Function to remove ANSI escape codes
    strip_ansi_codes() {
        sed 's/\x1b\[[0-9;]*m//g'
    }

    # Extract the folder name from the path
    FOLDER=$(basename "$ZOXIDE_RESULT")

    # Check if zellij is running using pgrep
    if pgrep -x "zellij" > /dev/null; then
        echo "Zellij is running."
        # Find existing sessions
        SESSION=$(zellij ls | strip_ansi_codes | grep " $FOLDER\b" | awk '{print $1}')
        echo "$SESSION"

        CURRENTSESSION=$(zellij ls | strip_ansi_codes | grep "(current)" | awk '{print $1}')

        if [ -z "$SESSION" ]; then
            echo "Session doesn't exist"
            # Open kitty and run zellij inside the folder
            kitty --hold --directory "$ZOXIDE_RESULT" -e "zellij attach -c '$FOLDER'"
        else
            echo "Session exists"
            zellij kill-session "$CURRENTSESSION"
            # Open kitty and run zellij inside the folder
            kitty --hold --directory "$ZOXIDE_RESULT" -e "zellij attach -c '$FOLDER'"
        fi
    else
        echo "Zellij is not running."
        # Find existing sessions
        SESSION=$(zellij ls | strip_ansi_codes | grep "$FOLDER\b" | awk '{print $1}')
        echo "$SESSION"
        
        if [ -z "$SESSION" ]; then
            echo "Session doesn't exist"
            # Open kitty and run zellij inside the folder
            kitty --hold --directory "$ZOXIDE_RESULT" -e "zellij attach -c '$FOLDER'"
        else
            echo "Session exists"
            kitty --hold --directory "$ZOXIDE_RESULT" -e "zellij attach '$SESSION'"
        fi
    fi
''

