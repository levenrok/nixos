{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.unstable.emacs-gtk;
    extraPackages = with pkgs.emacsPackages; [
      vterm
    ];
  };
}
