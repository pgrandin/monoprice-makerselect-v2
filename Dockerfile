FROM ubuntu:22.04
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install platformio
RUN apt-get install -y git
# ARG CACHE_DATE=not_a_date

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN git clone https://github.com/MarlinFirmware/Marlin.git Marlin
WORKDIR /Marlin
RUN git checkout 2.1.2.5

# MKS SBASE specifics
RUN sed -i -e 's@#define MOTHERBOARD BOARD_RAMPS_14_EFB@#define MOTHERBOARD BOARD_MKS_SBASE@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define X_DRIVER_TYPE  A4988@#define X_DRIVER_TYPE  DRV8825@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define Y_DRIVER_TYPE  A4988@#define Y_DRIVER_TYPE  DRV8825@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define Z_DRIVER_TYPE  A4988@#define Z_DRIVER_TYPE  DRV8825@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@//#define Z2_DRIVER_TYPE A4988@#define Z2_DRIVER_TYPE DRV8825@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define E0_DRIVER_TYPE A4988@#define E0_DRIVER_TYPE DRV8825@w changelog' Marlin/Configuration.h && [ -s changelog ]

# RUN sed -i -e 's@#define NUM_Z_STEPPER_DRIVERS 1@#define NUM_Z_STEPPER_DRIVERS 2@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@#define DIGIPOT_I2C_NUM_CHANNELS 8@#define DIGIPOT_I2C_NUM_CHANNELS 5@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]

RUN sed -i -e 's@#define SERIAL_PORT 0@#define SERIAL_PORT -1@w changelog' Marlin/Configuration.h && [ -s changelog ]

RUN sed -i -e 's@//#define DIGIPOT_MCP4451@#define DIGIPOT_MCP4451@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@#define DIGIPOT_I2C_MOTOR_CURRENTS { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0 } // AZTEEG_X3_PRO@#define DIGIPOT_I2C_MOTOR_CURRENTS { 0.7, 0.7, 0.7, 1.7, 0.7 } //  MKS SBASE: 5@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@//#define DIGIPOT_I2C_ADDRESS_A 0x2C@#define DIGIPOT_I2C_ADDRESS_A 0x2C@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@//#define DIGIPOT_I2C_ADDRESS_B 0x2D@#define DIGIPOT_I2C_ADDRESS_B 0x2D@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]

# Heated bed
RUN sed -i -e 's@//#define PIDTEMPBED@#define PIDTEMPBED@w changelog' Marlin/Configuration.h && [ -s changelog ]

# Inverted endstops and axes
RUN sed -i -e 's@#define X_MIN_ENDSTOP_INVERTING false@#define X_MIN_ENDSTOP_INVERTING true@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define Y_MIN_ENDSTOP_INVERTING false@#define Y_MIN_ENDSTOP_INVERTING true@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define INVERT_Y_DIR true@#define INVERT_Y_DIR false@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define INVERT_Z_DIR false@#define INVERT_Z_DIR true@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define INVERT_E0_DIR false@#define INVERT_E0_DIR true@w changelog' Marlin/Configuration.h && [ -s changelog ]


# Bed leveling
RUN sed -i -e 's@//#define AUTO_BED_LEVELING_LINEAR@#define AUTO_BED_LEVELING_LINEAR@w changelog' Marlin/Configuration.h && [ -s changelog ]
# RUN sed -i -e 's@//#define LCD_BED_LEVELING@#define LCD_BED_LEVELING@w changelog' Marlin/Configuration.h && [ -s changelog ]
# RUN sed -i -e 's@//#define LEVEL_BED_CORNERS@#define LEVEL_BED_CORNERS@w changelog' Marlin/Configuration.h && [ -s changelog ]

# Enable EEPROM
RUN sed -i -e 's@//#define EEPROM_SETTINGS@#define EEPROM_SETTINGS@w changelog' Marlin/Configuration.h && [ -s changelog ]

# Z Offset
RUN sed -i -e 's@//#define PROBE_OFFSET_WIZARD @#define PROBE_OFFSET_WIZARD @w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@//#define PROBE_OFFSET_WIZARD_START_Z@#define PROBE_OFFSET_WIZARD_START_Z@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@//#define BABYSTEP_DISPLAY_TOTAL@#define BABYSTEP_DISPLAY_TOTAL@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@//#define BABYSTEP_ZPROBE_OFFSET@#define BABYSTEP_ZPROBE_OFFSET@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]

# Calibration
RUN sed -i -e 's@#define DEFAULT_AXIS_STEPS_PER_UNIT   { 80, 80, 400, 500 }@#define DEFAULT_AXIS_STEPS_PER_UNIT   { 160, 160, 800, 1700 }@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define HOMING_FEEDRATE_MM_M { (50\*60), (50\*60), (4\*60) }@#define HOMING_FEEDRATE_MM_M { (100*60), (100*60), (16*60) }@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define MANUAL_FEEDRATE { 50\*60, 50\*60, 4\*60, 2\*60 }@#define MANUAL_FEEDRATE { 50*60, 50*60, 4*60, 10*60 }@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]

# PID settings
RUN sed -i -e 's@#define DEFAULT_Kp  22.20@#define DEFAULT_Kp 34.5740@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define DEFAULT_Ki   1.08@#define DEFAULT_Ki  3.4402@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define DEFAULT_Kd 114.00@#define DEFAULT_Kd 86.8671@w changelog' Marlin/Configuration.h && [ -s changelog ]

RUN sed -i -e 's@#define DEFAULT_bedKp 10.00@#define DEFAULT_bedKp 136.50@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define DEFAULT_bedKi .023@#define DEFAULT_bedKi 26.43@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define DEFAULT_bedKd 305.4@#define DEFAULT_bedKd 470.01@w changelog' Marlin/Configuration.h && [ -s changelog ]

# BL Touch settings
RUN sed -i -e 's@//#define BLTOUCH@#define BLTOUCH@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define NOZZLE_TO_PROBE_OFFSET { 10, 10, 0 }@#define NOZZLE_TO_PROBE_OFFSET { -24, -36, -3.7 }@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@//#define Z_SAFE_HOMING@#define Z_SAFE_HOMING@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define Z_SAFE_HOMING_X_POINT X_CENTER@#define Z_SAFE_HOMING_X_POINT ((X_BED_SIZE) / 2)@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define Z_SAFE_HOMING_Y_POINT Y_CENTER@#define Z_SAFE_HOMING_Y_POINT ((Y_BED_SIZE) / 2)@w changelog' Marlin/Configuration.h && [ -s changelog ]


# TFT35
# General options which MUST be activated:
RUN sed -i -e 's@//#define REPRAP_DISCOUNT_FULL_GRAPHIC_SMART_CONTROLLER$@#define REPRAP_DISCOUNT_FULL_GRAPHIC_SMART_CONTROLLER@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@//#define SERIAL_PORT_2 -1$@#define SERIAL_PORT_2 0@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@//#define BABYSTEPPING@#define BABYSTEPPING@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
#RUN sed -i -e 's@//#define AUTO_REPORT_TEMPERATURES@#define AUTO_REPORT_TEMPERATURES@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@//#define AUTO_REPORT_POSITION@#define AUTO_REPORT_POSITION@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@//#define M115_GEOMETRY_REPORT@#define M115_GEOMETRY_REPORT@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@//#define M114_DETAIL@#define M114_DETAIL@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@//#define REPORT_FAN_CHANGE@#define REPORT_FAN_CHANGE@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
# Options to support dialog with host:
RUN sed -i -e 's@//#define EMERGENCY_PARSER@#define EMERGENCY_PARSER@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@//#define SERIAL_FLOAT_PRECISION 4@#define SERIAL_FLOAT_PRECISION 4@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@//#define HOST_ACTION_COMMANDS@#define HOST_ACTION_COMMANDS@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@//#define HOST_PROMPT_SUPPORT@#define HOST_PROMPT_SUPPORT@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
# Options to support M600 with host & (Un)Load menu:
RUN sed -i -e 's@//#define NOZZLE_PARK_FEATURE@#define NOZZLE_PARK_FEATURE@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@//#define ADVANCED_PAUSE_FEATURE@#define ADVANCED_PAUSE_FEATURE@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@//#define PARK_HEAD_ON_PAUSE@#define PARK_HEAD_ON_PAUSE@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@//#define FILAMENT_LOAD_UNLOAD_GCODES@#define FILAMENT_LOAD_UNLOAD_GCODES@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]

# Options to fully support Bed Leveling menu:
RUN sed -i -e 's@//#define Z_MIN_PROBE_REPEATABILITY_TEST@#define Z_MIN_PROBE_REPEATABILITY_TEST@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@//#define G26_MESH_VALIDATION@#define G26_MESH_VALIDATION@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@//#define Z_STEPPER_AUTO_ALIGN@#define Z_STEPPER_AUTO_ALIGN@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]

# Bed size and offset corrections
# Actual usable bed space: 194x205mm with proper offsets for 0,0 alignment
RUN sed -i -e 's@#define X_BED_SIZE 200@#define X_BED_SIZE 194@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define Y_BED_SIZE 200@#define Y_BED_SIZE 205@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define X_MIN_POS 0@#define X_MIN_POS -15@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define Y_MIN_POS 0@#define Y_MIN_POS -8@w changelog' Marlin/Configuration.h && [ -s changelog ]

# Adjust probe grid to stay within bed bounds
# Probe is 24mm RIGHT of nozzle (despite negative offset in config)
# Min probe X=9 (nozzle at -15), Max probe X=154 (with 40mm right margin)
RUN sed -i -e 's@#define PROBING_MARGIN 10@#define PROBING_MARGIN 20@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN sed -i -e 's@#define PROBING_MARGIN_LEFT PROBING_MARGIN@#define PROBING_MARGIN_LEFT 10@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@#define PROBING_MARGIN_RIGHT PROBING_MARGIN@#define PROBING_MARGIN_RIGHT 40@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@#define PROBING_MARGIN_FRONT PROBING_MARGIN@#define PROBING_MARGIN_FRONT 30@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN sed -i -e 's@#define PROBING_MARGIN_BACK PROBING_MARGIN@#define PROBING_MARGIN_BACK 55@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]

# Enable onboard SD card connection (for OctoPrint firmware updates)
RUN sed -i -e 's@//#define SDCARD_CONNECTION LCD@#define SDCARD_CONNECTION ONBOARD@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]

RUN platformio run -e LPC1768

RUN md5sum .pio/build/LPC1768/firmware.bin
