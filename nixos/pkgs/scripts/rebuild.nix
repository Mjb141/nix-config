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
    echo "NixOS Rebuilt."

    # Get current nix generation metadata
    current_nix=$(nixos-rebuild list-generations | grep current)

    # Commit and push all changes with the generation metadata
    git commit -am "Nix $current_nix"
    git push --set-upstream origin main
    echo "NixOS Pushed."

    echo "Home-Manager Rebuilding..."
    home-manager switch --flake ~/Projects/nix-config/#michael@nixos &>switch.log || (cat switch.log | grep --color error && exit 1)
    echo "Home-Manager Rebuilt."

    # Get current home generation metadata
    current_home=$(home-manager generations | head -n 1 | awk -F '>' '{print $1}')

    # Commit and push all changes with the generation metadata
    git commit -am "Home $current_home"
    git push --set-upstream origin main
    echo "Home-Manager Pushed."

    # Back to where you were
    popd

    # Notify all OK!
    echo "Rebuild Complete!"
  '';
in {
  environment.systemPackages = [rebuild];
}
