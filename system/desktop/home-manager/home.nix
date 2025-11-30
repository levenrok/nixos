{ config, pkgs, pkgs-unstable, ... }:
let
  user = "levenrok";
  home = "/home/${user}";

  dotfiles = "${home}/.dotfiles/config";

  config_dotfiles = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  imports = [
    ./../../../modules/vscode.nix
  ];

  home = {
    username = "${user}";
    homeDirectory = "${home}";
    packages = (with pkgs; [
      dbgate

      protonup
    ]) ++ (with pkgs-unstable; [
      opencode
    ]);
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
    stateVersion = "25.05";
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.gnome-shell = {
    enable = true;
    extensions = [
      { package = pkgs.gnomeExtensions.appindicator; }
      { package = pkgs.gnomeExtensions.dash-to-dock; }
      { package = pkgs.gnomeExtensions.tophat; }
    ];
  };

  programs.starship = {
    enable = true;
    package = pkgs-unstable.starship;
  };

  programs.ghostty = {
    enable = true;
    package = pkgs-unstable.ghostty;
    enableBashIntegration = true;
    settings = {
      theme = "light:TokyoNight Day,dark:TokyoNight";
      font-family = "JetBrainsMono Nerd Font Mono";
      font-size = "14";

      window-width = "132";
      window-height = "28";

      cursor-style = "bar";

      shell-integration-features = "no-cursor";
    };
  };

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      # LSP
      nixd
      lua-language-server
      bash-language-server
      yaml-language-server
      taplo
      docker-language-server
      nginx-language-server
      # Formatter
      nixpkgs-fmt
      stylua
      shfmt
    ];
  };

  xdg.configFile = {
    "bat" = {
      source = config_dotfiles "${dotfiles}/bat";
      recursive = true;
    };
    "mc/ini" = {
      source = config_dotfiles "${dotfiles}/mc/ini";
      recursive = false;
    };
    "starship.toml" = {
      source = config_dotfiles "${dotfiles}/starship.toml";
      recursive = false;
    };
    "eza/theme.yml" = {
      source = config_dotfiles "${dotfiles}/eza-theme.yml";
      recursive = false;
    };
    "nvim" = {
      source = config_dotfiles "${dotfiles}/nvim";
      recursive = true;
    };
  };
}
