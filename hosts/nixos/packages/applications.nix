{ pkgs, ... }:


with pkgs; [
    #------------ // Browsers -------------
    brave
    firefox
    #------------ // Social -------------
    discord
    telegram-desktop
    slack

    #------------ // Network -------------
    networkmanagerapplet
    dnsmasq
    #------------ // Programming -------------
    postman
    pgadmin4
    pgadmin4-desktopmode
    #------------ // Screen shot -------------
    gimp
    grim
    grimblast
    swww # wallpaper setter

    blender # doing 3d
    obs-studio # screen record and stream
    obsidian # note taking tool
    zathura # pdf reader
    appimage-run # runs appimages
    torrential # torrent downloadder

    #------------ // idle manager ------------
    swayidle
    swaylock-effects

    #------------ // window manager thing-------------
    waybar
    wl-clipboard
    hyprpicker
    brightnessctl
    # wifi
    hotspot
    linux-wifi-hotspot
    wlogout

    # terminal
    kitty

  ]
