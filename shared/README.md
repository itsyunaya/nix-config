# Shared Nix modules

The modules contained in this directory are not guaranteed to
have an interface compatible with all platforms, and should
therefore not be imported via `lib/recursiveImport.nix`.

## Overview

| Module          | Consumable as       |
|-----------------|---------------------|
| mnw             | all (Flake input)   |
| spicetify       | all (Flake input)   |
| git             | all (local import)  |
| common-packages | workstation systems |
