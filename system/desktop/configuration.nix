{ config, pkgs, ... }:

let
  user = "levenrok";
  host = "levens-desktop";

  bin = "/run/current-system/sw/bin";
in
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 7;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "${host}";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Colombo";

  i18n.defaultLocale = "en_GB.UTF-8";

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  hardware = {
    graphics.enable = true;
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  virtualisation.docker.enable = true;

  users.users.${user} = {
    isNormalUser = true;
    description = "Leven Rochana";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  security.sudo = {
    enable = true;
    extraRules = [
      {
        groups = [ "wheel" ];
        commands = [
          {
            command = "${bin}/systemctl suspend";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${bin}/systemctl poweroff";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${bin}/systemctl reboot";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${bin}/systemctl status *";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${bin}/journalctl";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };

  security.pam.services.gdm.enableGnomeKeyring = true;
  security.pam.services.hyprlock.enableGnomeKeyring = true;

  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = false;

  programs.steam = {
    enable = true;
  };

  programs.gamemode.enable = true;

  environment.systemPackages = (with pkgs; [
    vim
    git
    curl

    gcc
    gnumake

    figlet
    xclip
    xsel
    wl-clipboard
    libnotify

    google-chrome
    vlc
    spotify
    discord
    aseprite
  ]) ++ (with pkgs.unstable; [
    go-task
    jq

    ripgrep
    fd
    fzf
    zoxide
    eza
    bat
    fastfetch

    hyprpaper
    hyprcursor
    hypridle
    hyprlock
    rofi
    quickshell
    swaynotificationcenter
    swayosd
    playerctl
  ]);

  fonts.packages = with pkgs;
    [
      nerd-fonts.jetbrains-mono
    ];

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = "25.05";
}
