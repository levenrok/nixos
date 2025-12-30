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
      ];
    };
  };
}
