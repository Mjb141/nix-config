{
  config,
  pkgs,
  ...
}: let
  rebuild = pkgs.writeShellScriptBin "rebuild" ''
    # Source: https://gist.github.com/0atman/1a5133b842f929ba4c1e195ee67599d5
    #
    # A rebuild script that commits on a successful build
    set -e

    # cd to your config dir
    pushd ~/Projects/nix-config/

    # Early return if no changes were detected (thanks @singiamtel!)
    if git diff --quiet '*.nix'; then
        echo "No changes detected, exiting."
        popd
        exit 0
    fi

    # Autoformat your nix files
    alejandra . &>/dev/null \
      || ( alejandra . ; echo "formatting failed!" && exit 1)

    # Shows your changes
    git diff -U0 '*.nix'

    echo "NixOS Rebuilding..."

    # Rebuild, output simplified errors, log tracebacks
    sudo nixos-rebuild switch --flake ~/Projects/nix-config/#nixos &>switch.log || (cat switch.log | grep --color error && exit 1)

    # Get current generation metadata
    current=$(nixos-rebuild list-generations | grep current)

    # Commit all changes witih the generation metadata
    git commit -am "$current"

    # Back to where you were
    popd

    # Notify all OK!
    echo "NixOS Rebuilt OK!"
  '';
in {
  environment.systemPackages = [rebuild];
}
