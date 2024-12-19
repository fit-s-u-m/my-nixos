{ config, ... }:

{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        action = "sleep 1; systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        "label" = "reboot";
        "action" = "sleep 1; systemctl reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
      {
        "label" = "logout";
        "action" = "sleep 1; hyprctl dispatch exit";
        "text" = "Exit";
        "keybind" = "e";
      }
      {
        "label" = "suspend";
        "action" = "sleep 1; systemctl suspend";
        "text" = "Suspend";
        "keybind" = "u";
      }
      {
        "label" = "lock";
        "action" = "sleep 1; hyprlock";
        "text" = "Lock";
        "keybind" = "l";
      }
      {
        "label" = "hibernate";
        "action" = "sleep 1; systemctl hibernate";
        "text" = "Hibernate";
        "keybind" = "h";
      }
    ];
    style = ''
      * {
        font-family: "JetBrainsMono NF", FontAwesome, sans-serif;
      	background-image: none;
      	transition: 20ms;
      }
      window {
      	# background-color: rgba(12, 12, 12, 0.1);
        background-color: transparent;
      }
      button {
      	color: #${config.stylix.base16Scheme.base05};
        font-size:16px;
        outline-style: none;
        border: none;
        border-width: 0px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 10%;
        border-radius: 0px;
        box-shadow: none;
        text-shadow: none;
        animation: gradient_f 20s ease-in infinite;
            background-repeat: no-repeat;
          	background-position: center;
          	background-size: 25%;
          	border-style: solid;
          	background-color: rgba(12, 12, 12, 0.3);
          	border: 3px solid #${config.stylix.base16Scheme.base05};
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
      }
      button:focus,
      button:active,
      button:hover {
        color: #${config.stylix.base16Scheme.base0B};
        background-color: rgba(12, 12, 12, 0.5);
        border: 3px solid #${config.stylix.base16Scheme.base0B};
        animation: gradient_f 20s ease-in infinite;
        transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
      }
       #logout {
       	margin: 10px;
       	border-radius: 20px;
       	background-image: image(url("icons/logout.png"));
       }
       #suspend {
       	margin: 10px;
       	border-radius: 20px;
       	background-image: image(url("icons/suspend.png"));
       }
       #shutdown {
       	margin: 10px;
       	border-radius: 20px;
       	background-image: image(url("icons/shutdown.png"));
       }
       #reboot {
       	margin: 10px;
       	border-radius: 20px;
       	background-image: image(url("icons/reboot.png"));
       }
       #lock {
       	margin: 10px;
       	border-radius: 20px;
       	background-image: image(url("icons/lock.png"));
       }
       #hibernate {
       	margin: 10px;
       	border-radius: 20px;
       	background-image: image(url("icons/hibernate.png"));
       }
      button:hover#hibernate {
          margin : 10px 0px 0px 10px;
      }

      button:hover#logout {
          margin : 0px 0px 10px 10px;
      }

      button:hover#shutdown {
          margin : 5px 10px 0px 0px;
      }

      button:hover#reboot {
          margin : 0px 10px 10px 0px;
      }

      #hibernate {
      	  background-image: image(url("icons/logout.png"));
      	border-radius: 20px;
          margin : 10px 0px 0px 10px;
      }

      #logout {
      	  background-image: image(url("icons/logout.png"));
      	border-radius: 20px;
          margin : 0px 0px 10px 10px;
      }

      #shutdown {
      	  background-image: image(url("icons/logout.png"));
      	border-radius: 20px;
          margin : 10px 10px 0px 0px;
      }

      #reboot {
      	  background-image: image(url("icons/logout.png"));
      	border-radius: 20px;
          margin : 0px 10px 10px 0px;
      }
    '';
  };
}
