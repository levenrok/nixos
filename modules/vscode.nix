{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    profiles.default = {
      userSettings = {
        "[css]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[json]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[jsonc]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[javascriptreact]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[php]" = {
          "editor.defaultFormatter" = "laravel.vscode-laravel";
        };
        "[typescript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[typescriptreact]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "editor.fontSize" = 17;
        "editor.fontFamily" = "JetBrainsMono Nerd Font Mono";
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.lineNumbers" = "relative";
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
          "<C-k>" = false;
          "<C-p>" = false;
        };
        "vim.normalModeKeyBindingsNonRecursive" = [
          {
            "before" = [ "leader" "e" ];
            "commands" = [ "workbench.view.explorer" ];
          }
          {
            "before" = [ "K" ];
            "commands" = [ "editor.action.showHover" ];
          }
        ];
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
        bradlc.vscode-tailwindcss
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
