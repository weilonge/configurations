# Nix Simple Guide

## Installation

See: https://github.com/DeterminateSystems/nix-installer

Run `curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install`

## Package Management

- Update package list
  - Happens automatically
- Search
  - `nix search nixpkgs <pkgname>`
- Install
  - `nix profile install nixpkgs#<pkgname>`
- Upgrade installed
  - `nix profile upgrade --all`
- List installed
  - `nix profile list`
- Remove
  - `nix profile remove <pkgname>`
- Rollback
  - `nix profile rollback`
- Clean up store
  - `nix-store --gc`
- Check nix disk usage
  - `df -h /nix`
