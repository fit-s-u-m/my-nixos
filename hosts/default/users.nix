{
  pkgs,
  username,
  ...
}:

let
  inherit (import ./variables.nix) gitUsername;
in
{
  users.users = {
    "${username}" = {
      shell = pkgs.zsh;
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "docker"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
      ];
      ignoreShellProgramCheck = true;
    };
  };
}
