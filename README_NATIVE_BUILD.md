# Native GitHub Actions Build

This branch uses a native GitHub Actions workflow to build Marlin firmware without Docker.

## What Changed

### Previous Approach (Docker)
- Dockerfile with 40+ sed commands to modify configuration
- Slow builds (clone Marlin + apply patches every time)
- Configuration changes buried in Dockerfile
- Hard to track what's actually configured

### New Approach (Native)
- Pre-configured `Configuration.h` and `Configuration_adv.h` files
- All changes visible in version control
- Faster builds with caching
- Easier to maintain and review changes

## Configuration Files

The `Configuration.h` and `Configuration_adv.h` files contain all the customizations for the Monoprice Maker Select V2:

- **Board**: MKS SBASE (LPC1768)
- **Drivers**: DRV8825 on all axes
- **Bed Size**: 194x205mm with offsets (-15, -8)
- **Probe**: BLTouch at offset (-24, -36, -3.7)
- **Auto Bed Leveling**: LINEAR mode with 3x3 grid
- **Features**: EEPROM, Z Safe Homing, M600, Babystepping, etc.

## Building Locally

```bash
# Install PlatformIO
pip install platformio

# Clone Marlin
git clone https://github.com/MarlinFirmware/Marlin.git
cd Marlin
git checkout 2.1.2.5

# Copy our configuration files
cp ../Configuration*.h Marlin/

# Build
platformio run -e LPC1768

# Firmware will be at: .pio/build/LPC1768/firmware.bin
```

## GitHub Actions Workflow

The workflow (`build-firmware-native.yml`):
1. Caches Marlin source code
2. Installs PlatformIO
3. Copies our configuration files
4. Builds the firmware
5. Creates artifacts with firmware and build info

## Migration from Docker

To generate the configuration files from the Dockerfile:
1. Run `apply_marlin_config.sh` - extracts all sed commands and applies them
2. This creates properly configured files that match what Docker was building

## Advantages

1. **Transparency**: All configuration visible in git diff
2. **Speed**: Cached dependencies, no Docker overhead
3. **Maintainability**: Easy to see and change settings
4. **Version Control**: Track configuration changes properly
5. **Local Development**: Same files work locally and in CI