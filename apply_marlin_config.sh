#!/bin/bash
set -euo pipefail

CONFIG_DIR=${1:-.}
CONFIG_H="$CONFIG_DIR/Configuration.h"
CONFIG_ADV="$CONFIG_DIR/Configuration_adv.h"

if [[ ! -f $CONFIG_H || ! -f $CONFIG_ADV ]]; then
  echo "Expected Configuration.h and Configuration_adv.h in $CONFIG_DIR" >&2
  exit 1
fi

echo "Applying Marlin configuration changes in $CONFIG_DIR..."

ensure_contains() {
  local file=$1 needle=$2
  if ! grep -qF "$needle" "$file"; then
    echo "Failed to apply configuration change: expected '$needle' in $file" >&2
    exit 1
  fi
}



# Configuration.h changes
echo "Updating Configuration.h..."

# MKS SBASE specifics
sed -i 's@#define MOTHERBOARD BOARD_RAMPS_14_EFB@#define MOTHERBOARD BOARD_MKS_SBASE@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define MOTHERBOARD BOARD_MKS_SBASE'
sed -i 's@#define X_DRIVER_TYPE  A4988@#define X_DRIVER_TYPE  DRV8825@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define X_DRIVER_TYPE  DRV8825'
sed -i 's@#define Y_DRIVER_TYPE  A4988@#define Y_DRIVER_TYPE  DRV8825@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define Y_DRIVER_TYPE  DRV8825'
sed -i 's@#define Z_DRIVER_TYPE  A4988@#define Z_DRIVER_TYPE  DRV8825@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define Z_DRIVER_TYPE  DRV8825'
sed -i 's@//#define Z2_DRIVER_TYPE A4988@#define Z2_DRIVER_TYPE DRV8825@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define Z2_DRIVER_TYPE DRV8825'
sed -i 's@#define E0_DRIVER_TYPE A4988@#define E0_DRIVER_TYPE DRV8825@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define E0_DRIVER_TYPE DRV8825'

# Serial configuration
sed -i 's@#define SERIAL_PORT 0@#define SERIAL_PORT -1@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define SERIAL_PORT -1'
sed -i 's@//#define SERIAL_PORT_2 -1$@#define SERIAL_PORT_2 0@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define SERIAL_PORT_2 0'

# Heated bed PID
sed -i 's@//#define PIDTEMPBED@#define PIDTEMPBED@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define PIDTEMPBED'

# Inverted endstops and axes
sed -i 's@#define X_MIN_ENDSTOP_INVERTING false@#define X_MIN_ENDSTOP_INVERTING true@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define X_MIN_ENDSTOP_INVERTING true'
sed -i 's@#define Y_MIN_ENDSTOP_INVERTING false@#define Y_MIN_ENDSTOP_INVERTING true@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define Y_MIN_ENDSTOP_INVERTING true'
sed -i 's@#define INVERT_Y_DIR true@#define INVERT_Y_DIR false@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define INVERT_Y_DIR false'
sed -i 's@#define INVERT_Z_DIR false@#define INVERT_Z_DIR true@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define INVERT_Z_DIR true'
sed -i 's@#define INVERT_E0_DIR false@#define INVERT_E0_DIR true@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define INVERT_E0_DIR true'

# Bed leveling
sed -i 's@//#define AUTO_BED_LEVELING_LINEAR@#define AUTO_BED_LEVELING_LINEAR@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define AUTO_BED_LEVELING_LINEAR'

# Enable EEPROM
sed -i 's@//#define EEPROM_SETTINGS@#define EEPROM_SETTINGS@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define EEPROM_SETTINGS'

# Calibration
sed -i 's@#define DEFAULT_AXIS_STEPS_PER_UNIT   { 80, 80, 400, 500 }@#define DEFAULT_AXIS_STEPS_PER_UNIT   { 160, 160, 800, 1700 }@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define DEFAULT_AXIS_STEPS_PER_UNIT   { 160, 160, 800, 1700 }'
sed -i 's@#define HOMING_FEEDRATE_MM_M { (50\*60), (50\*60), (4\*60) }@#define HOMING_FEEDRATE_MM_M { (100*60), (100*60), (16*60) }@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define HOMING_FEEDRATE_MM_M { (100*60), (100*60), (16*60) }'

# PID settings - Hotend
sed -i 's@#define DEFAULT_Kp  22.20@#define DEFAULT_Kp 34.5740@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define DEFAULT_Kp 34.5740'
sed -i 's@#define DEFAULT_Ki   1.08@#define DEFAULT_Ki  3.4402@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define DEFAULT_Ki  3.4402'
sed -i 's@#define DEFAULT_Kd 114.00@#define DEFAULT_Kd 86.8671@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define DEFAULT_Kd 86.8671'

# PID settings - Bed
sed -i 's@#define DEFAULT_bedKp 10.00@#define DEFAULT_bedKp 136.50@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define DEFAULT_bedKp 136.50'
sed -i 's@#define DEFAULT_bedKi .023@#define DEFAULT_bedKi 26.43@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define DEFAULT_bedKi 26.43'
sed -i 's@#define DEFAULT_bedKd 305.4@#define DEFAULT_bedKd 470.01@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define DEFAULT_bedKd 470.01'

# BL Touch settings
sed -i 's@//#define BLTOUCH@#define BLTOUCH@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define BLTOUCH'
sed -i 's@#define NOZZLE_TO_PROBE_OFFSET { 10, 10, 0 }@#define NOZZLE_TO_PROBE_OFFSET { -24, -36, -3.7 }@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define NOZZLE_TO_PROBE_OFFSET { -24, -36, -3.7 }'
sed -i 's@//#define Z_SAFE_HOMING@#define Z_SAFE_HOMING@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define Z_SAFE_HOMING'
sed -i 's@#define Z_SAFE_HOMING_X_POINT X_CENTER@#define Z_SAFE_HOMING_X_POINT ((X_BED_SIZE) / 2)@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define Z_SAFE_HOMING_X_POINT ((X_BED_SIZE) / 2)'
sed -i 's@#define Z_SAFE_HOMING_Y_POINT Y_CENTER@#define Z_SAFE_HOMING_Y_POINT ((Y_BED_SIZE) / 2)@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define Z_SAFE_HOMING_Y_POINT ((Y_BED_SIZE) / 2)'

# TFT35 Display
sed -i 's@//#define REPRAP_DISCOUNT_FULL_GRAPHIC_SMART_CONTROLLER$@#define REPRAP_DISCOUNT_FULL_GRAPHIC_SMART_CONTROLLER@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define REPRAP_DISCOUNT_FULL_GRAPHIC_SMART_CONTROLLER'

# M600 Support
sed -i 's@//#define NOZZLE_PARK_FEATURE@#define NOZZLE_PARK_FEATURE@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define NOZZLE_PARK_FEATURE'

# Bed leveling testing
sed -i 's@//#define Z_MIN_PROBE_REPEATABILITY_TEST@#define Z_MIN_PROBE_REPEATABILITY_TEST@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define Z_MIN_PROBE_REPEATABILITY_TEST'
sed -i 's@//#define G26_MESH_VALIDATION@#define G26_MESH_VALIDATION@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define G26_MESH_VALIDATION'

# Bed size and offset corrections
sed -i 's@#define X_BED_SIZE 200@#define X_BED_SIZE 194@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define X_BED_SIZE 194'
sed -i 's@#define Y_BED_SIZE 200@#define Y_BED_SIZE 205@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define Y_BED_SIZE 205'
sed -i 's@#define X_MIN_POS 0@#define X_MIN_POS -15@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define X_MIN_POS -15'
sed -i 's@#define Y_MIN_POS 0@#define Y_MIN_POS -8@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define Y_MIN_POS -8'

# Probing margin
sed -i 's@#define PROBING_MARGIN 10@#define PROBING_MARGIN 20@' "$CONFIG_H"
ensure_contains "${CONFIG_H}" '#define PROBING_MARGIN 20'

echo "Configuration.h updated!"

# Configuration_adv.h changes
echo "Updating Configuration_adv.h..."

# MKS SBASE Digipot configuration
sed -i 's@#define DIGIPOT_I2C_NUM_CHANNELS 8@#define DIGIPOT_I2C_NUM_CHANNELS 5@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define DIGIPOT_I2C_NUM_CHANNELS 5'
sed -i 's@//#define DIGIPOT_MCP4451@#define DIGIPOT_MCP4451@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define DIGIPOT_MCP4451'
sed -i 's@#define DIGIPOT_I2C_MOTOR_CURRENTS { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0 } // AZTEEG_X3_PRO@#define DIGIPOT_I2C_MOTOR_CURRENTS { 0.7, 0.7, 0.7, 1.7, 0.7 } //  MKS SBASE: 5@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define DIGIPOT_I2C_MOTOR_CURRENTS { 0.7, 0.7, 0.7, 1.7, 0.7 } //  MKS SBASE: 5'
sed -i 's@//#define DIGIPOT_I2C_ADDRESS_A 0x2C@#define DIGIPOT_I2C_ADDRESS_A 0x2C@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define DIGIPOT_I2C_ADDRESS_A 0x2C'
sed -i 's@//#define DIGIPOT_I2C_ADDRESS_B 0x2D@#define DIGIPOT_I2C_ADDRESS_B 0x2D@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define DIGIPOT_I2C_ADDRESS_B 0x2D'

# Z Offset Wizard and Babystepping
sed -i 's@//#define PROBE_OFFSET_WIZARD @#define PROBE_OFFSET_WIZARD @' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define PROBE_OFFSET_WIZARD '
sed -i 's@//#define PROBE_OFFSET_WIZARD_START_Z@#define PROBE_OFFSET_WIZARD_START_Z@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define PROBE_OFFSET_WIZARD_START_Z'
sed -i 's@//#define BABYSTEP_DISPLAY_TOTAL@#define BABYSTEP_DISPLAY_TOTAL@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define BABYSTEP_DISPLAY_TOTAL'
sed -i 's@//#define BABYSTEP_ZPROBE_OFFSET@#define BABYSTEP_ZPROBE_OFFSET@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define BABYSTEP_ZPROBE_OFFSET'
sed -i 's@//#define BABYSTEPPING@#define BABYSTEPPING@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define BABYSTEPPING'

# Manual feedrate
sed -i 's@#define MANUAL_FEEDRATE { 50\*60, 50\*60, 4\*60, 2\*60 }@#define MANUAL_FEEDRATE { 50*60, 50*60, 4*60, 10*60 }@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define MANUAL_FEEDRATE { 50*60, 50*60, 4*60, 10*60 }'

# TFT35 - Host communication features
sed -i 's@//#define AUTO_REPORT_POSITION@#define AUTO_REPORT_POSITION@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define AUTO_REPORT_POSITION'
sed -i 's@//#define M115_GEOMETRY_REPORT@#define M115_GEOMETRY_REPORT@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define M115_GEOMETRY_REPORT'
sed -i 's@//#define M114_DETAIL@#define M114_DETAIL@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define M114_DETAIL'
sed -i 's@//#define REPORT_FAN_CHANGE@#define REPORT_FAN_CHANGE@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define REPORT_FAN_CHANGE'
sed -i 's@//#define EMERGENCY_PARSER@#define EMERGENCY_PARSER@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define EMERGENCY_PARSER'
sed -i 's@//#define SERIAL_FLOAT_PRECISION 4@#define SERIAL_FLOAT_PRECISION 4@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define SERIAL_FLOAT_PRECISION 4'
sed -i 's@//#define HOST_ACTION_COMMANDS@#define HOST_ACTION_COMMANDS@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define HOST_ACTION_COMMANDS'
sed -i 's@//#define HOST_PROMPT_SUPPORT@#define HOST_PROMPT_SUPPORT@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define HOST_PROMPT_SUPPORT'

# M600 Support
sed -i 's@//#define ADVANCED_PAUSE_FEATURE@#define ADVANCED_PAUSE_FEATURE@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define ADVANCED_PAUSE_FEATURE'
sed -i 's@//#define PARK_HEAD_ON_PAUSE@#define PARK_HEAD_ON_PAUSE@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define PARK_HEAD_ON_PAUSE'
sed -i 's@//#define FILAMENT_LOAD_UNLOAD_GCODES@#define FILAMENT_LOAD_UNLOAD_GCODES@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define FILAMENT_LOAD_UNLOAD_GCODES'

# Z Stepper alignment
sed -i 's@//#define Z_STEPPER_AUTO_ALIGN@#define Z_STEPPER_AUTO_ALIGN@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define Z_STEPPER_AUTO_ALIGN'

# Probing margins
sed -i 's@#define PROBING_MARGIN_LEFT PROBING_MARGIN@#define PROBING_MARGIN_LEFT 10@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define PROBING_MARGIN_LEFT 10'
sed -i 's@#define PROBING_MARGIN_RIGHT PROBING_MARGIN@#define PROBING_MARGIN_RIGHT 40@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define PROBING_MARGIN_RIGHT 40'
sed -i 's@#define PROBING_MARGIN_FRONT PROBING_MARGIN@#define PROBING_MARGIN_FRONT 30@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define PROBING_MARGIN_FRONT 30'
sed -i 's@#define PROBING_MARGIN_BACK PROBING_MARGIN@#define PROBING_MARGIN_BACK 55@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define PROBING_MARGIN_BACK 55'

# Enable onboard SD card connection (for OctoPrint firmware updates)
sed -i 's@//#define SDCARD_CONNECTION LCD@#define SDCARD_CONNECTION ONBOARD@' "$CONFIG_ADV"
ensure_contains "${CONFIG_ADV}" '#define SDCARD_CONNECTION ONBOARD'

echo "Configuration_adv.h updated!"
echo "All configuration changes applied successfully!"
