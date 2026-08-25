# nix-config
## Introduction

This is my personal Nix (Flakes) configuration made for a few of my devices. It is a
continuation of my [previous attempt](https://github.com/itsyunaya/nixos-config-old) of
getting acquainted with Nix, but now actually stable and usable as a daily driver.

## Specifications
### Input pinning

Instead of using the `inputs` attrset in `flake.nix`, this configuration uses
[tack](https://github.com/manic-systems/tack) to manage its' inputs. See the
`.tack/` directory for more info.

### Hosts

> [!CAUTION]
> If you wish to use any of these configurations on your own device, you need
> to first replace the respective hardware configuration with your own,
> otherwise your system will not boot!

| Host                  | Description                                      |
|-----------------------|--------------------------------------------------|
| `juno`                | Main x86 Linux machine                           |
| `ceres`               | Raspberry Pi nixOS setup for pi-hole             |
| `callisto`            | Server configuration                             |
| `ashleys-macbook-pro` | Apple Silicon Mac configuration using nix-darwin |

### juno

This is the configuration I use on my main machine. It uses the 
[mango wayland compositor](https://github.com/mangowm/mango), a custom Astal/AGS 
top bar, the Anyrun app runner, and other components needed to assemble a full 
desktop shell experience.

(Screenshots coming soon)

### ceres

Minimal NixOS config just for deploying [Pi-Hole](https://pi-hole.net/) on a Raspberry Pi 4B.

### callisto

Server configuration including but not limited to:
- Nextcloud & Samba Servers for data management
- Monitoring via Grafana
- Various Webservers
- Gameservers

### ashleys-macbook-pro

Minimal nix-darwin configuration. Only has some basic packages and a 
simple shell setup for now.

## Other

The `shared/` directory includes common configuration and modules which 
are to a degree portable between Nix-based platforms. This has been 
achieved with the use of [adios](https://github.com/llakala/lladios) and 
[adios-wrappers](https://github.com/llakala/adios-wrappers). It also
contains modules which are portable through other means like
[mnw](https://github.com/Gerg-L/mnw).

`packages/` contains self-made or vendored package derivations.

## Note

This config is still work in progress and may change drastically at any time.