# nix-config

### System

To apply system changes:

`sudo nixos-rebuild switch --flake .#nixos`

### Home

To apply home changes:

`home-manager switch --flake .#michael@nixos
