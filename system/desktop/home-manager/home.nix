{ config, pkgs, ... }:
let
  username = "levenrok";
  homePath = "/home/${username}";

  dotfilesPath = "${homePath}/.dotfiles/config";

  configDotfiles = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  imports = [
    ./../../../modules/tools.nix

    ./../../../modules/editor/neovim.nix
    ./../../../modules/editor/emacs.nix
    ./../../../modules/editor/vscode.nix

    ./../../../modules/config/tools.nix
    ./../../../modules/config/hyprland.nix
  ];

  _module.args = {
    inherit dotfilesPath;
    inherit configDotfiles;
  };

  home = {
    username = "${username}";
    homeDirectory = "${homePath}";
    packages = with pkgs; [
      protonup-ng
    ];
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
    stateVersion = "25.05";
  };

  home.file = {
    ".bashrc".source = configDotfiles "${dotfilesPath}/.bashrc";
    ".bash_aliases".source = configDotfiles "${dotfilesPath}/.bash_aliases";
    ".bash_profile".source = configDotfiles "${dotfilesPath}/.bash_profile";
    ".inputrc".source = configDotfiles "${dotfilesPath}/.inputrc";
    ".gitconfig".source = configDotfiles "${dotfilesPath}/.gitconfig";
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };

  programs.gnome-shell = {
    enable = true;
    extensions = [
      { package = pkgs.gnomeExtensions.appindicator; }
      { package = pkgs.gnomeExtensions.dash-to-dock; }
      { package = pkgs.gnomeExtensions.blur-my-shell; }
      { package = pkgs.gnomeExtensions.tophat; }
      { package = pkgs.gnomeExtensions.gsconnect; }
    ];
  };
}
