{ config, pkgs, pkgs-unstable, ... }:
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
      dbgate
      gemini-cli

      protonup
    ];
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

  programs.starship.enable = true;

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

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    profiles.default = {
      userSettings = {
        "[php]" = {
          "editor.defaultFormatter" = "laravel.vscode-laravel";
        };
        "editor.fontSize" = 17;
        "editor.fontFamily" = "JetBrainsMono Nerd Font Mono";
        "editor.fontLigatures" = true;
        "editor.linkedEditing" = true;
        "editor.minimap.enabled" = false;
        "emmet.includeLanguages" = {
          "blade" = "html";
        };
        "extensions.experimental.affinity" = {
          "vscodevim.vim" = 1;
        };
        "git.enableCommitSigning" = true;
        "git.followTagsWhenSync" = true;
        "terminal.integrated.fontLigatures.enabled" = true;
        "vim.leader" = "<space>";
        "vim.handleKeys" = {
          "<C-b>" = false;
          "<C-p>" = false;
        };
        "vim.useSystemClipboard" = true;
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
        dbaeumer.vscode-eslint
        editorconfig.editorconfig
        enkia.tokyo-night
        esbenp.prettier-vscode
        redhat.ansible
        redhat.vscode-yaml
        usernamehw.errorlens
        vscodevim.vim
        xdebug.php-debug
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-laravel";
          publisher = "laravel";
          version = "1.2.1";
          sha256 = "8e8eaae632543ccf366c32babf68271f41d46cab12b7d0d245a743e6bdbb45ed";
        }
        {
          name = "vscode-blade-formatter";
          publisher = "shufo";
          version = "0.26.2";
          sha256 = "a7449e76198004f4972973b89d9e98536cbf2081b1c3382d7d703003ba25873e";
        }
      ];
    };
  };
}
