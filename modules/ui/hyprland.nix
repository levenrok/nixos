{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  security.pam.services.hyprlock.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs.unstable; [
    hyprpaper
    hyprcursor
    hypridle
    hyprlock
    rofi
    quickshell
    grim
    slurp
    swaynotificationcenter
    swayosd
    playerctl
  ];
}
