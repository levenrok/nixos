{ pkgs, ... }:
{
  home.packages =
    (with pkgs;[
      bash-language-server

      shfmt
      shellcheck
    ]) ++ (with pkgs.unstable;[
      clang

      just

      zoxide
      eza
      ripgrep
      bat
      fd
      fzf
      jq

      fastfetch
      lazygit
      lazydocker
      opencode

      firefox-devedition
      dbgate
    ]);

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.starship = {
    enable = true;
    package = pkgs.unstable.starship;
  };

  programs.ghostty = {
    enable = true;
    package = pkgs.unstable.ghostty;
    enableBashIntegration = true;
  };
}
