{ dotfilesPath, configDotfiles, ... }:
{
  xdg.configFile = {
    "bat" = {
      source = configDotfiles "${dotfilesPath}/bat";
      recursive = true;
    };
    "eza/theme.yml" = {
      source = configDotfiles "${dotfilesPath}/eza-theme.yml";
      recursive = false;
    };
    "fastfetch" = {
      source = configDotfiles "${dotfilesPath}/fastfetch";
      recursive = false;
    };
    "starship.toml" = {
      source = configDotfiles "${dotfilesPath}/starship.toml";
      recursive = false;
    };
    "ghostty/config" = {
      source = configDotfiles "${dotfilesPath}/ghostty";
      recursive = false;
    };
  };
}
