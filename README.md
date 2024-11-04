# delta

Road to the Heavens

## Overview

Main Components:
- `assets`
- `feathers`
- `login`
- `sddm`
- `cache`

## Breakdown

CONFIG-SYSTEM-ONLY:
- `sddm`:  system-wide only; user writes allowed with sudo perms (effect of /etc, so I don't have to do anything) [behavior=Password]
  - system-wide: `/etc/icarus/sddm`
- `version`: system-wide only; readonly [behavior=Locked]
  - system-wide: `/etc/icarus/version`

AMASS:
- `assets`: both system-wide and user-scoped
  - system-wide: `/usr/local/share/icarus/assets`
  - user-scoped: `$HOME/.local/share/icarus/assets`
- `feathers`: both system-wide and user-scoped
  - system-wide: `/usr/local/share/icarus/feathers`   <- `feathers cd --system`
  - user-scoped: `$HOME/.local/share/icarus/feathers` <- `feathers cd`

CONFIG-OVERRIDE:
- `login`: user-scoped, but with system-wide defaults; user writes allowed to the defaults with sudo perms
  - system-wide: `/etc/icarus/login`
  - user-scoped: `$HOME/.local/share/icarus/login`

USER-ONLY:
- `cache`: user-scoped only
  - user-scoped: `$HOME/.local/share/icarus/cache`

OTHER: any folder prefixed with `__` you can probably infer where it will go or it is special
