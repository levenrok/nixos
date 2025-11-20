{ config, pkgs, ... }:
let
  user = "levenrok";
  home = "/home/${user}";

  dotfiles = "${home}/.dotfiles/config";

  config_dotfiles = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  home = {
    username = "${user}";
    homeDirectory = "${home}";
    packages = with pkgs; [
      dbeaver-bin
    ];
  };
  home.stateVersion = "25.05";

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

  xdg.configFile."bat" = {
    source = config_dotfiles "${dotfiles}/bat";
    recursive = true;
  };

  xdg.configFile."mc/ini" = {
    source = config_dotfiles "${dotfiles}/mc/ini";
    recursive = false;
  };

  programs.gnome-shell = {
    enable = true;
    extensions = [
      { package = pkgs.gnomeExtensions.appindicator; }
      { package = pkgs.gnomeExtensions.dash-to-dock; }
      { package = pkgs.gnomeExtensions.tophat; }
    ];
  };

  programs.google-chrome.enable = true;

  programs.starship.enable = true;

  xdg.configFile."starship.toml" = {
    source = config_dotfiles "${dotfiles}/starship.toml";
    recursive = false;
  };

  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      theme = "light:tokyonight-day,dark:tokyonight_night";
      font-family = "JetBrainsMono Nerd Font Mono";
      font-size = "14";

      cursor-style = "bar";

      shell-integration-features = "no-cursor";
    };
  };

  xdg.configFile."eza/theme.yml" = {
    source = config_dotfiles "${dotfiles}/eza-theme.yml";
    recursive = false;
  };

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      # LSP
      nixd
      lua-language-server
      bash-language-server
      gopls
      yaml-language-server
      taplo
      # Formatter
      nixpkgs-fmt
      stylua
      shfmt
    ];
  };

  xdg.configFile."nvim" = {
    source = config_dotfiles "${dotfiles}/nvim";
    recursive = true;
  };

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    profiles.default = {
      userSettings = {
        "editor.fontSize" = 17;
        "editor.fontFamily" = "JetBrainsMono Nerd Font Mono";
        "editor.linkedEditing" = true;
        "editor.minimap.enabled" = false;
        "git.enableCommitSigning" = true;
        "git.followTagsWhenSync" = true;
        "workbench.activityBar.location" = "top";
        "window.autoDetectColorScheme" = true;
        "workbench.iconTheme" = "catppuccin-latte";
        "workbench.preferredDarkColorTheme" = "Tokyo Night";
        "workbench.preferredLightColorTheme" = "Tokyo Night Light";
        "workbench.startupEditor" = "welcomePageInEmptyWorkbench";
      };

      extensions = with pkgs.vscode-extensions; [
        bierner.github-markdown-preview
        bmewburn.vscode-intelephense-client
        catppuccin.catppuccin-vsc-icons
        editorconfig.editorconfig
        enkia.tokyo-night
        usernamehw.errorlens
        redhat.ansible
        redhat.vscode-yaml
        xdebug.php-debug
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-laravel";
          publisher = "laravel";
          version = "1.2.1";
          sha256 = "8e8eaae632543ccf366c32babf68271f41d46cab12b7d0d245a743e6bdbb45ed";
        }
      ];
    };
  };
}
