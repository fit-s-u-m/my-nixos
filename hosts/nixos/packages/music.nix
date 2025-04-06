{ pkgs, ... }:


with pkgs; [
  # --------------------------------------------------- // Music
  cava # audio visualizer
  spicetify-cli # cli to customize spotify client
  spotify # spotify client
  ncmpcpp # terminal music player
  mpv # video player
  ffmpeg # general purpose to edit and convert music and videos
  playerctl
  mpd
  mpdris2
  pulseaudioFull # audio control
]

