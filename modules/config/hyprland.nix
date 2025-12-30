{ dotfilesPath, configDotfiles, ... }:
{
  xdg.configFile = {
    "hypr" = {
      source = configDotfiles "${dotfilesPath}/hypr";
      recursive = true;
    };
    "uwsm" = {
      source = configDotfiles "${dotfilesPath}/uwsm";
      recursive = true;
    };
    "swaync" = {
      source = configDotfiles "${dotfilesPath}/swaync";
      recursive = true;
    };
    "swayosd" = {
      source = configDotfiles "${dotfilesPath}/swayosd";
      recursive = true;
    };
    "rofi" = {
      source = configDotfiles "${dotfilesPath}/rofi";
      recursive = true;
    };
    "quickshell" = {
      source = configDotfiles "${dotfilesPath}/quickshell";
      recursive = true;
    };
  };
}
