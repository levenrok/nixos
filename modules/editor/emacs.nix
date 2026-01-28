{
  pkgs,
  dotfilesPath,
  configDotfiles,
  ...
}:
{
  programs.emacs = {
    enable = true;
    package = pkgs.unstable.emacs-gtk;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  xdg.configFile."doom" = {
    source = configDotfiles "${dotfilesPath}/doom";
    recursive = true;
  };
}
