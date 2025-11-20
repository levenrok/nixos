# NixOS Configuration

## Usage

1. Clone the repository with submodules
```sh
git clone --recursive git@github.com:levenrok/nixos.git
cd nixos
```

2. Deploy the configuration
```sh
nixos-rebuild switch --flake .#<hostname>
```

## Update

### Main Configuration

1. Add the changes
```sh
git add .
```

2. Commit the changes
```sh
git commit -m "update main config"
```

3. Push the changes
```sh
git push origin main
```

### Submodules

1. Checkout the main branch
```sh
cd config
git checkout main
```

2. Add and Commit the changes
```sh
git commit -am "update submodule"
```

3. Push the changes
```sh
git push origin main
```

4. Update the main configuration pointer
```sh
cd ..
git add config
git commit -m "update dotfiles submodule"
git push origin main
```