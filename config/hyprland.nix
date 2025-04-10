{
  lib,
  username,
  host,
  ...
}:

let
  inherit (import ../hosts/${host}/variables.nix)
    browser
    terminal
    keyboardLayout
    ;
in
with lib;
{
  wayland.windowManager.hyprland = {
    enable = true;
    # xwayland.enable = true;
    systemd.enable = true;
    extraConfig =
      let
        modifier = "SUPER";
      in
      concatStrings [
        ''
          env = NIXOS_OZONE_WL, 1
          env = NIXPKGS_ALLOW_UNFREE, 1
          env = XDG_CURRENT_DESKTOP, Hyprland
          env = XDG_SESSION_TYPE, wayland
          env = XDG_SESSION_DESKTOP, Hyprland
          env = GDK_BACKEND, wayland, x11
          env = CLUTTER_BACKEND, wayland
          env = QT_QPA_PLATFORM=wayland;xcb
          env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
          env = SDL_VIDEODRIVER, x11
          env = MOZ_ENABLE_WAYLAND, 1
          env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
          exec-once = dbus-update-activation-environment --systemd --all
          exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
          exec-once = killall -q swww;sleep .5 && swww init
          exec-once = killall -q waybar;sleep .5 && waybar
          exec-once = killall -q swaync;sleep .5 && swaync
          exec-once = nm-applet --indicator
          exec-once = lxqt-policykit-agent
          exec-once = sleep 1.5 && swww img /home/${username}/Pictures/Wallpapers/mountainscapedark.jpg
          exec-once = my-lock
          exec-once = battery-notify


          monitor=,preferred,auto,1
          general {
            gaps_in = 6
            gaps_out = 8
            border_size = 3
            layout = dwindle
            resize_on_border = true
          }
          input {
            kb_layout = ${keyboardLayout}
            kb_options = grp:alt_shift_toggle
            kb_options = ctrl:nocaps
            follow_mouse = 1
            touchpad {
              natural_scroll = true
              disable_while_typing = true
              scroll_factor = 0.8
            }
            sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
            accel_profile = flat
          }
          gestures {
            workspace_swipe = true
            workspace_swipe_fingers = 3
          }
          decoration {
            rounding = 10
            dim_inactive = true
            dim_strength = 0.3
            shadow {
              enabled = true
              range = 10
              render_power = 3
              color = 0xee1a1a1a
            }
          }

          windowrule = noborder,^(wofi)$
          windowrule = center,^(wofi)$
          windowrule = center,^(steam)$
          windowrule = float, nm-connection-editor|blueman-manager
          windowrule = float, swayimg|vlc|Viewnior|pavucontrol
          windowrule = float, zoom
          windowrulev2 = stayfocused, title:^()$,class:^(steam)$
          windowrulev2 = minsize 1 1, title:^()$,class:^(steam)$
          windowrulev2 = opacity 0.9 0.7, class:^(Brave)$
          windowrulev2 = opacity 0.9 0.7, class:^(thunar)$
          misc {
            initial_workspace_tracking = 0
            mouse_move_enables_dpms = true
            key_press_enables_dpms = false
          }
          animations {
            enabled = yes
            bezier = wind, 0.05, 0.9, 0.1, 1.05
            bezier = winIn, 0.1, 1.1, 0.1, 1.1
            bezier = winOut, 0.3, -0.3, 0, 1
            bezier = liner, 1, 1, 1, 1
            animation = windows, 1, 6, wind, slide
            animation = windowsIn, 1, 6, winIn, slide
            animation = windowsMove, 1, 5, wind, slide
            animation = border, 1, 1, liner
            animation = fade, 1, 10, default
            animation = workspaces, 1, 5, wind
          }
          dwindle {
            pseudotile = true
            preserve_split = true
          }
          bind = ${modifier},Return,exec,${terminal}
          bind = ${modifier}SHIFT,Return,exec,rofi-launcher
          bind = ${modifier}SHIFT,W,exec,web-search
          bind = ALT SHIFT,right,exec,wallsetter
          bind = ${modifier}SHIFT,N,exec,swaync-client -rs
          bind = ${modifier},W,exec,${browser}
          bind = ${modifier},Apostrophe ,exec,emopicker9000
          bind = ${modifier},P,exec,screenshootin
          bind = ${modifier}SHIFT,P,exec,hyprpicker -a
          bind = ${modifier},D, exec,session-manager
          bind = ${modifier},O,exec,obs
          bind = ${modifier},c,exec,rofi -show calc -modi calc -no-show-match -no-sort
          bind = ${modifier},G,exec,gimp
          bind = ${modifier}SHIFT,G,exec,godot4
          bind = ${modifier},E,exec,thunar
          bind = ${modifier},M,exec,spotify
          bind = ${modifier},ESCAPE,killactive,
          bind = ${modifier},P,pseudo,
          bind = ${modifier}SHIFT,I,togglesplit,
          bind = ${modifier},F,fullscreen,
          bind = ${modifier}SHIFT,F,togglefloating,
          bind = ${modifier}SHIFT,C,exit,
          # bind = ${modifier},D, exec, bemenu-run   --hb '##467b96' --hf '##dfdfdf' --tb '##467b96' --tf '##dfdfdf' -H 30  -p 'Run:'

          # Resize windows
          binde = ${modifier}+Shift, Right, resizeactive, 30 0
          binde = ${modifier}+Shift, Left, resizeactive, -30 0
          binde = ${modifier}+Shift, Up, resizeactive, 0 -30
          binde = ${modifier}+Shift, Down, resizeactive, 0 30

          bind = ${modifier}SHIFT,h,movewindow,l
          bind = ${modifier}SHIFT,l,movewindow,r
          bind = ${modifier}SHIFT,k,movewindow,u
          bind = ${modifier}SHIFT,j,movewindow,d
          bind = ${modifier},left,movefocus,l
          bind = ${modifier},right,movefocus,r
          bind = ${modifier},up,movefocus,u
          bind = ${modifier},down,movefocus,d
          bind = ${modifier},h,movefocus,l
          bind = ${modifier},l,movefocus,r
          bind = ${modifier},k,movefocus,u
          bind = ${modifier},j,movefocus,d
          bind = ${modifier},1,workspace,1
          bind = ${modifier},2,workspace,2
          bind = ${modifier},3,workspace,3
          bind = ${modifier},4,workspace,4
          bind = ${modifier},5,workspace,5
          bind = ${modifier},6,workspace,6
          bind = ${modifier},7,workspace,7
          bind = ${modifier},8,workspace,8
          bind = ${modifier},9,workspace,9
          bind = ${modifier},0,workspace,10
          bind = ${modifier}SHIFT,SPACE,movetoworkspace,special
          bind = ${modifier},SPACE,togglespecialworkspace
          bind = ${modifier}SHIFT,1,movetoworkspace,1
          bind = ${modifier}SHIFT,2,movetoworkspace,2
          bind = ${modifier}SHIFT,3,movetoworkspace,3
          bind = ${modifier}SHIFT,4,movetoworkspace,4
          bind = ${modifier}SHIFT,5,movetoworkspace,5
          bind = ${modifier}SHIFT,6,movetoworkspace,6
          bind = ${modifier}SHIFT,7,movetoworkspace,7
          bind = ${modifier}SHIFT,8,movetoworkspace,8
          bind = ${modifier}SHIFT,9,movetoworkspace,9
          bind = ${modifier}SHIFT,0,movetoworkspace,10
          bind = ${modifier}CONTROL,right,workspace,e+1
          bind = ${modifier}CONTROL,left,workspace,e-1
          bind = ${modifier},mouse_down,workspace, e+1
          bind = ${modifier},mouse_up,workspace, e-1
          bindm = ${modifier},mouse:272,movewindow
          bindm = ${modifier},mouse:273,resizewindow
          bind = ${modifier}, Tab,workspace, previous
          # bind = ${modifier},Tab,bringactivetotop
          bind = ${modifier}, BackSpace,exec,hyprlock
          bind = ${modifier}SHIFT, BackSpace,exec,wlogout

          bind =  ${modifier},Equal,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
          bind =  ${modifier},Minus,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
          bindel = ,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
          bindel = ,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
          bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
          bind = ${modifier}SHIFT,M,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

          bind = ${modifier}SHIFT,Equal,exec,playerctl next
          bind = ${modifier}SHIFT,Minus,exec,playerctl previous
          bind = ${modifier},slash, exec, playerctl play-pause

          bindel = ,XF86AudioNext, exec, playerctl next
          bindel = ,XF86AudioPrev, exec, playerctl previous

          bindel = ,XF86AudioPlay, exec, playerctl play-pause
          bindel = ,XF86AudioPause, exec, playerctl play-pause
          bindel = ,XF86MonBrightnessDown,exec,brightnessctl set 5%-
          bindel = ,XF86MonBrightnessUp,exec,brightnessctl set +5%
          bindel = ${modifier}SHIFT,F5,exec,hyprctl reload
        ''
      ];
  };}
