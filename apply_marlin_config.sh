#!/bin/bash
# Script to apply all Marlin configuration changes from Dockerfile

echo "Applying Marlin configuration changes..."

# Configuration.h changes
echo "Updating Configuration.h..."

# MKS SBASE specifics
sed -i 's@#define MOTHERBOARD BOARD_RAMPS_14_EFB@#define MOTHERBOARD BOARD_MKS_SBASE@' Configuration.h
sed -i 's@#define X_DRIVER_TYPE  A4988@#define X_DRIVER_TYPE  DRV8825@' Configuration.h
sed -i 's@#define Y_DRIVER_TYPE  A4988@#define Y_DRIVER_TYPE  DRV8825@' Configuration.h
sed -i 's@#define Z_DRIVER_TYPE  A4988@#define Z_DRIVER_TYPE  DRV8825@' Configuration.h
sed -i 's@//#define Z2_DRIVER_TYPE A4988@#define Z2_DRIVER_TYPE DRV8825@' Configuration.h
sed -i 's@#define E0_DRIVER_TYPE A4988@#define E0_DRIVER_TYPE DRV8825@' Configuration.h

# Serial configuration
sed -i 's@#define SERIAL_PORT 0@#define SERIAL_PORT -1@' Configuration.h
sed -i 's@//#define SERIAL_PORT_2 -1$@#define SERIAL_PORT_2 0@' Configuration.h

# Heated bed PID
sed -i 's@//#define PIDTEMPBED@#define PIDTEMPBED@' Configuration.h

# Inverted endstops and axes
sed -i 's@#define X_MIN_ENDSTOP_INVERTING false@#define X_MIN_ENDSTOP_INVERTING true@' Configuration.h
sed -i 's@#define Y_MIN_ENDSTOP_INVERTING false@#define Y_MIN_ENDSTOP_INVERTING true@' Configuration.h
sed -i 's@#define INVERT_Y_DIR true@#define INVERT_Y_DIR false@' Configuration.h
sed -i 's@#define INVERT_Z_DIR false@#define INVERT_Z_DIR true@' Configuration.h
sed -i 's@#define INVERT_E0_DIR false@#define INVERT_E0_DIR true@' Configuration.h

# Bed leveling
sed -i 's@//#define AUTO_BED_LEVELING_LINEAR@#define AUTO_BED_LEVELING_LINEAR@' Configuration.h

# Enable EEPROM
sed -i 's@//#define EEPROM_SETTINGS@#define EEPROM_SETTINGS@' Configuration.h

# Calibration
sed -i 's@#define DEFAULT_AXIS_STEPS_PER_UNIT   { 80, 80, 400, 500 }@#define DEFAULT_AXIS_STEPS_PER_UNIT   { 160, 160, 800, 1700 }@' Configuration.h
sed -i 's@#define HOMING_FEEDRATE_MM_M { (50\*60), (50\*60), (4\*60) }@#define HOMING_FEEDRATE_MM_M { (100*60), (100*60), (16*60) }@' Configuration.h

# PID settings - Hotend
sed -i 's@#define DEFAULT_Kp  22.20@#define DEFAULT_Kp 34.5740@' Configuration.h
sed -i 's@#define DEFAULT_Ki   1.08@#define DEFAULT_Ki  3.4402@' Configuration.h
sed -i 's@#define DEFAULT_Kd 114.00@#define DEFAULT_Kd 86.8671@' Configuration.h

# PID settings - Bed
sed -i 's@#define DEFAULT_bedKp 10.00@#define DEFAULT_bedKp 136.50@' Configuration.h
sed -i 's@#define DEFAULT_bedKi .023@#define DEFAULT_bedKi 26.43@' Configuration.h
sed -i 's@#define DEFAULT_bedKd 305.4@#define DEFAULT_bedKd 470.01@' Configuration.h

# BL Touch settings
sed -i 's@//#define BLTOUCH@#define BLTOUCH@' Configuration.h
sed -i 's@#define NOZZLE_TO_PROBE_OFFSET { 10, 10, 0 }@#define NOZZLE_TO_PROBE_OFFSET { -24, -36, -3.7 }@' Configuration.h
sed -i 's@//#define Z_SAFE_HOMING@#define Z_SAFE_HOMING@' Configuration.h
sed -i 's@#define Z_SAFE_HOMING_X_POINT X_CENTER@#define Z_SAFE_HOMING_X_POINT ((X_BED_SIZE) / 2)@' Configuration.h
sed -i 's@#define Z_SAFE_HOMING_Y_POINT Y_CENTER@#define Z_SAFE_HOMING_Y_POINT ((Y_BED_SIZE) / 2)@' Configuration.h

# TFT35 Display
sed -i 's@//#define REPRAP_DISCOUNT_FULL_GRAPHIC_SMART_CONTROLLER$@#define REPRAP_DISCOUNT_FULL_GRAPHIC_SMART_CONTROLLER@' Configuration.h

# M600 Support
sed -i 's@//#define NOZZLE_PARK_FEATURE@#define NOZZLE_PARK_FEATURE@' Configuration.h

# Bed leveling testing
sed -i 's@//#define Z_MIN_PROBE_REPEATABILITY_TEST@#define Z_MIN_PROBE_REPEATABILITY_TEST@' Configuration.h
sed -i 's@//#define G26_MESH_VALIDATION@#define G26_MESH_VALIDATION@' Configuration.h

# Bed size and offset corrections
sed -i 's@#define X_BED_SIZE 200@#define X_BED_SIZE 194@' Configuration.h
sed -i 's@#define Y_BED_SIZE 200@#define Y_BED_SIZE 205@' Configuration.h
sed -i 's@#define X_MIN_POS 0@#define X_MIN_POS -15@' Configuration.h
sed -i 's@#define Y_MIN_POS 0@#define Y_MIN_POS -8@' Configuration.h

# Probing margin
sed -i 's@#define PROBING_MARGIN 10@#define PROBING_MARGIN 20@' Configuration.h

echo "Configuration.h updated!"

# Configuration_adv.h changes
echo "Updating Configuration_adv.h..."

# MKS SBASE Digipot configuration
sed -i 's@#define DIGIPOT_I2C_NUM_CHANNELS 8@#define DIGIPOT_I2C_NUM_CHANNELS 5@' Configuration_adv.h
sed -i 's@//#define DIGIPOT_MCP4451@#define DIGIPOT_MCP4451@' Configuration_adv.h
sed -i 's@#define DIGIPOT_I2C_MOTOR_CURRENTS { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0 } // AZTEEG_X3_PRO@#define DIGIPOT_I2C_MOTOR_CURRENTS { 0.7, 0.7, 0.7, 1.7, 0.7 } //  MKS SBASE: 5@' Configuration_adv.h
sed -i 's@//#define DIGIPOT_I2C_ADDRESS_A 0x2C@#define DIGIPOT_I2C_ADDRESS_A 0x2C@' Configuration_adv.h
sed -i 's@//#define DIGIPOT_I2C_ADDRESS_B 0x2D@#define DIGIPOT_I2C_ADDRESS_B 0x2D@' Configuration_adv.h

# Z Offset Wizard and Babystepping
sed -i 's@//#define PROBE_OFFSET_WIZARD @#define PROBE_OFFSET_WIZARD @' Configuration_adv.h
sed -i 's@//#define PROBE_OFFSET_WIZARD_START_Z@#define PROBE_OFFSET_WIZARD_START_Z@' Configuration_adv.h
sed -i 's@//#define BABYSTEP_DISPLAY_TOTAL@#define BABYSTEP_DISPLAY_TOTAL@' Configuration_adv.h
sed -i 's@//#define BABYSTEP_ZPROBE_OFFSET@#define BABYSTEP_ZPROBE_OFFSET@' Configuration_adv.h
sed -i 's@//#define BABYSTEPPING@#define BABYSTEPPING@' Configuration_adv.h

# Manual feedrate
sed -i 's@#define MANUAL_FEEDRATE { 50\*60, 50\*60, 4\*60, 2\*60 }@#define MANUAL_FEEDRATE { 50*60, 50*60, 4*60, 10*60 }@' Configuration_adv.h

# TFT35 - Host communication features
sed -i 's@//#define AUTO_REPORT_POSITION@#define AUTO_REPORT_POSITION@' Configuration_adv.h
sed -i 's@//#define M115_GEOMETRY_REPORT@#define M115_GEOMETRY_REPORT@' Configuration_adv.h
sed -i 's@//#define M114_DETAIL@#define M114_DETAIL@' Configuration_adv.h
sed -i 's@//#define REPORT_FAN_CHANGE@#define REPORT_FAN_CHANGE@' Configuration_adv.h
sed -i 's@//#define EMERGENCY_PARSER@#define EMERGENCY_PARSER@' Configuration_adv.h
sed -i 's@//#define SERIAL_FLOAT_PRECISION 4@#define SERIAL_FLOAT_PRECISION 4@' Configuration_adv.h
sed -i 's@//#define HOST_ACTION_COMMANDS@#define HOST_ACTION_COMMANDS@' Configuration_adv.h
sed -i 's@//#define HOST_PROMPT_SUPPORT@#define HOST_PROMPT_SUPPORT@' Configuration_adv.h

# M600 Support
sed -i 's@//#define ADVANCED_PAUSE_FEATURE@#define ADVANCED_PAUSE_FEATURE@' Configuration_adv.h
sed -i 's@//#define PARK_HEAD_ON_PAUSE@#define PARK_HEAD_ON_PAUSE@' Configuration_adv.h
sed -i 's@//#define FILAMENT_LOAD_UNLOAD_GCODES@#define FILAMENT_LOAD_UNLOAD_GCODES@' Configuration_adv.h

# Z Stepper alignment
sed -i 's@//#define Z_STEPPER_AUTO_ALIGN@#define Z_STEPPER_AUTO_ALIGN@' Configuration_adv.h

# Probing margins
sed -i 's@#define PROBING_MARGIN_LEFT PROBING_MARGIN@#define PROBING_MARGIN_LEFT 10@' Configuration_adv.h
sed -i 's@#define PROBING_MARGIN_RIGHT PROBING_MARGIN@#define PROBING_MARGIN_RIGHT 40@' Configuration_adv.h
sed -i 's@#define PROBING_MARGIN_FRONT PROBING_MARGIN@#define PROBING_MARGIN_FRONT 30@' Configuration_adv.h
sed -i 's@#define PROBING_MARGIN_BACK PROBING_MARGIN@#define PROBING_MARGIN_BACK 55@' Configuration_adv.h

# Enable onboard SD card connection (for OctoPrint firmware updates)
sed -i 's@//#define SDCARD_CONNECTION LCD@#define SDCARD_CONNECTION ONBOARD@' Configuration_adv.h

echo "Configuration_adv.h updated!"
echo "All configuration changes applied successfully!"