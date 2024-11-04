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

AMASS:
- `assets`: both systemwide and user-scoped  [behavior=Amass]
  - systemwide: `/usr/local/share/icarus/assets`
  - user-scoped: `$HOME/.local/share/icarus/assets`
- `feathers`: both systemwide and user-scoped [behavior=Amass]
  - systemwide: `/usr/local/share/icarus/feathers`   <- `feathers cd --system`
  - user-scoped: `$HOME/.local/share/icarus/feathers` <- `feathers cd`

CONFIG-OVERRIDE:
- `login`: user-scoped, but with systemwide defaults [behavior=Override]; user writes allowed to the defaults with sudo perms
  - systemwide: `/etc/icarus/login`
  - user-scoped: `$HOME/.local/share/icarus/login`

CONFIG-SYSTEM-ONLY:
- `sddm`:  systemwide only; user writes allowed with sudo perms (effect of /etc, so I don't have to do anything) [behavior=Password]
  - systemwide: `/etc/icarus/sddm`
- `version`: systemwide only; readonly [behavior=Locked]
  - systemwide: `/etc/icarus/version`

USER-ONLY:
- `cache`: user-scoped only [behavior=ViaUser]
  - user-scoped: `$HOME/.local/share/icarus/cache`

OTHER: any folder prefixed with `__` you can probably infer where it will go or it is special
