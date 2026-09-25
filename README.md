![KruigerHandsUp](images/KruigerHandsUp-Banner.png)

# KruigerHandsUp — Free FiveM Hands Up & Kneel Script

KruigerHandsUp is a lightweight **standalone FiveM hands up script** with surrender and kneeling stances. It includes `/handsup`, `/huk`, configurable controls and client exports for integration with other FiveM resources.

## Features
- **X** toggles hands up/down
- `/handsup` toggles hands up/down
- `/huk` toggles hands-on-knees/kneeling stance
- Keeps the player's selected weapon when using `/huk`
- Automatically switches cleanly between surrender stances
- Cancels when dead, ragdolling, or entering a vehicle
- Blocks attacking, aiming, reloading, melee, and weapon wheel while surrendering
- Configurable animations and controls
- Client exports for integrations
- Standalone; no framework dependency

## Installation
Place `KruigerHandsUp` in your resources folder and add:
```cfg
ensure KruigerHandsUp
```

## Commands
```text
/handsup
/huk
```

## Exports
```lua
local handsUp = exports['KruigerHandsUp']:IsHandsUp()
local huk = exports['KruigerHandsUp']:IsHUK()
local stance = exports['KruigerHandsUp']:GetSurrenderStance()
```

## Documentation
- Full documentation: https://kruigerlabs.xyz/docs/free-scripts/kruigerhandsup
- FiveM scripts: https://kruigerlabs.xyz/fivem
- Documentation center: https://kruigerlabs.xyz/docs/

## License
Licensed under the **Kruiger Labs Community License v1.0**. See `LICENSE` for complete terms.
