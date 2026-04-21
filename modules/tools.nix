{ pkgs, ... }:
{
  home.packages =
    (with pkgs; [
      python3
      uv

      bash-language-server
      basedpyright

      shfmt
      shellcheck
    ])
    ++ (with pkgs.unstable; [
      nixfmt

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
      gemini-cli
      opencode

      firefox-devedition
      tor-browser
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
