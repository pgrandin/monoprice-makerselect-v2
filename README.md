# monoprice-makerselect-v2

Marlin firmware setup for a Monoprice Maker Select V2 running an MKS SBase v1.4. The build relies on applying a reproducible set of `sed` edits to upstream Marlin configuration files instead of tracking customised `Configuration*.h` files in the repo.

## Building the firmware

- Install Docker and run `./build.sh`.
- The script builds the image, compiles Marlin inside it, and leaves `firmware.bin` alongside a timestamped copy named after the current commit.

## Updating to a new Marlin release

1. Fetch the stock Marlin sources (e.g. `git clone https://github.com/MarlinFirmware/Marlin.git`).
2. Checkout the desired tag and run `./apply_marlin_config.sh /path/to/Marlin`. The script mutates the upstream `Configuration.h` and `Configuration_adv.h` in place.
3. Optionally run `./gen_patch.sh` to capture the diff as `sbase.patch` for review.
4. Rebuild with `./build.sh` to confirm the firmware still compiles.

Because all tweaks live in `apply_marlin_config.sh`, rerunning the script after upstream changes keeps the configuration consistent without needing to track generated config files in version control.
