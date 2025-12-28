install_dir := '$HOME/.local/bin'

# show available commands
default:
    @just -f {{justfile()}} --list

# install all scripts
install_all: install_flake_script install_custom_scripts

# install the flake setup script
install_flake_script:
    chmod +x "{{justfile_directory()}}/flakes/setup-devenv"
    ln -s "{{justfile_directory()}}/flakes/setup-devenv" "{{install_dir}}/setup-devenv"

# install the custom scripts
install_custom_scripts:
    chmod +x "{{justfile_directory()}}/scripts"
    ln -s "{{justfile_directory()}}/scripts" "{{install_dir}}/scripts"
