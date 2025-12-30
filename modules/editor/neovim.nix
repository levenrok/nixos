{ pkgs, dotfilesPath, configDotfiles, ... }:
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      # LSPs
      nixd
      lua-language-server

      yaml-language-server
      taplo
      vscode-langservers-extracted

      cmake-language-server
      docker-language-server
      nginx-language-server
      hyprls

      # Formatters
      nixpkgs-fmt
      stylua
    ];
  };

  xdg.configFile."nvim" = {
    source = configDotfiles "${dotfilesPath}/nvim";
    recursive = true;
  };
}
