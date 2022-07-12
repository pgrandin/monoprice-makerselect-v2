FROM ubuntu:22.04
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install platformio
RUN apt-get install -y git
ADD . /sbase
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# MKS SBASE specifics
RUN cd /sbase/Marlin && sed -i -e 's@#define MOTHERBOARD BOARD_RAMPS_14_EFB@#define MOTHERBOARD BOARD_MKS_SBASE@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define X_DRIVER_TYPE  A4988@#define X_DRIVER_TYPE  DRV8825@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define Y_DRIVER_TYPE  A4988@#define Y_DRIVER_TYPE  DRV8825@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define Z_DRIVER_TYPE  A4988@#define Z_DRIVER_TYPE  DRV8825@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define Z2_DRIVER_TYPE A4988@#define Z2_DRIVER_TYPE DRV8825@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define E0_DRIVER_TYPE A4988@#define E0_DRIVER_TYPE DRV8825@w changelog' Marlin/Configuration.h && [ -s changelog ]

RUN cd /sbase/Marlin && sed -i -e 's@#define NUM_Z_STEPPER_DRIVERS 1@#define NUM_Z_STEPPER_DRIVERS 2@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define DIGIPOT_I2C_NUM_CHANNELS 8@#define DIGIPOT_I2C_NUM_CHANNELS 5@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]

RUN cd /sbase/Marlin && sed -i -e 's@#define SERIAL_PORT 0@#define SERIAL_PORT -1@w changelog' Marlin/Configuration.h && [ -s changelog ]

RUN cd /sbase/Marlin && sed -i -e 's@//#define DIGIPOT_MCP4451@#define DIGIPOT_MCP4451@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define DIGIPOT_I2C_MOTOR_CURRENTS { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0 } // AZTEEG_X3_PRO@#define DIGIPOT_I2C_MOTOR_CURRENTS { 1.0, 1.0, 1.0, 1.0, 1.0 }  //  MKS SBASE: 5@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define DIGIPOT_I2C_ADDRESS_A 0x2C@#define DIGIPOT_I2C_ADDRESS_A 0x2C@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define DIGIPOT_I2C_ADDRESS_B 0x2D@#define DIGIPOT_I2C_ADDRESS_B 0x2D@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]

# Heated bed
RUN cd /sbase/Marlin && sed -i -e 's@#define TEMP_SENSOR_BED 0@#define TEMP_SENSOR_BED 1@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define PIDTEMPBED@#define PIDTEMPBED@w changelog' Marlin/Configuration.h && [ -s changelog ]

# Inverted endstops and axes
RUN cd /sbase/Marlin && sed -i -e 's@#define X_MIN_ENDSTOP_INVERTING false@#define X_MIN_ENDSTOP_INVERTING true@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define Y_MIN_ENDSTOP_INVERTING false@#define Y_MIN_ENDSTOP_INVERTING true@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define INVERT_Y_DIR true@#define INVERT_Y_DIR false@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define INVERT_Z_DIR false@#define INVERT_Z_DIR true@w changelog' Marlin/Configuration.h && [ -s changelog ]

# Bed leveling
RUN cd /sbase/Marlin && sed -i -e 's@//#define AUTO_BED_LEVELING_LINEAR@#define AUTO_BED_LEVELING_LINEAR@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define LCD_BED_LEVELING@#define LCD_BED_LEVELING@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define LEVEL_BED_CORNERS@#define LEVEL_BED_CORNERS@w changelog' Marlin/Configuration.h && [ -s changelog ]
# !! Bed size missing

# Enable EEPROM
RUN cd /sbase/Marlin && sed -i -e 's@//#define EEPROM_SETTINGS@#define EEPROM_SETTINGS@w changelog' Marlin/Configuration.h && [ -s changelog ]

# Z Offset
RUN cd /sbase/Marlin && sed -i -e 's@//#define PROBE_OFFSET_WIZARD @#define PROBE_OFFSET_WIZARD @w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define PROBE_OFFSET_WIZARD_START_Z@#define PROBE_OFFSET_WIZARD_START_Z@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define BABYSTEP_DISPLAY_TOTAL@#define BABYSTEP_DISPLAY_TOTAL@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define BABYSTEP_ZPROBE_OFFSET@#define BABYSTEP_ZPROBE_OFFSET@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]


# Calibration
RUN cd /sbase/Marlin && sed -i -e 's@#define DEFAULT_AXIS_STEPS_PER_UNIT   { 80, 80, 400, 500 }@#define DEFAULT_AXIS_STEPS_PER_UNIT   { 160, 160, 800, 1650 }@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define HOMING_FEEDRATE_MM_M { (50\*60), (50\*60), (4\*60) }@#define HOMING_FEEDRATE_MM_M { (100*60), (100*60), (16*60) }@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define MANUAL_FEEDRATE { 50\*60, 50\*60, 4\*60, 2\*60 }@#define MANUAL_FEEDRATE { 50*60, 50*60, 4*60, 10*60 }@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]

# PID settings
RUN cd /sbase/Marlin && sed -i -e 's@#define DEFAULT_Kp  22.20@#define DEFAULT_Kp 28.33@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define DEFAULT_Ki   1.08@#define DEFAULT_Ki  2.03@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define DEFAULT_Kd 114.00@#define DEFAULT_Kd 98.83@w changelog' Marlin/Configuration.h && [ -s changelog ]

RUN cd /sbase/Marlin && sed -i -e 's@#define DEFAULT_bedKp 10.00@#define DEFAULT_bedKp 136.50@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define DEFAULT_bedKi .023@#define DEFAULT_bedKi 26.43@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define DEFAULT_bedKd 305.4@#define DEFAULT_bedKd 470.01@w changelog' Marlin/Configuration.h && [ -s changelog ]

# BL Touch settings
RUN cd /sbase/Marlin && sed -i -e 's@//#define BLTOUCH@#define BLTOUCH@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define NOZZLE_TO_PROBE_OFFSET { 10, 10, 0 }@#define NOZZLE_TO_PROBE_OFFSET { -24, -36, -1.35 }@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define Z_SAFE_HOMING@#define Z_SAFE_HOMING@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define Z_SAFE_HOMING_X_POINT X_CENTER@#define Z_SAFE_HOMING_X_POINT ((X_BED_SIZE) / 2)@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@#define Z_SAFE_HOMING_Y_POINT Y_CENTER@#define Z_SAFE_HOMING_Y_POINT ((Y_BED_SIZE) / 2)@w changelog' Marlin/Configuration.h && [ -s changelog ]

# MKS screen
# RUN cd /sbase/Marlin && sed -i -e 's@//#define MKS_MINI_12864_V3@#define MKS_MINI_12864_V3@w changelog' Marlin/Configuration.h && [ -s changelog ] && grep MKS_MINI_12864_V3 Marlin/Configuration.h
# RUN cd /sbase/Marlin && sed -i -e 's@//#define NEOPIXEL_LED@#define NEOPIXEL_LED@w changelog' Marlin/Configuration.h && [ -s changelog ] && grep NEOPIXEL_LED Marlin/Configuration.h
# RUN cd /sbase/Marlin && sed -i -e 's@#define NEOPIXEL_TYPE          NEO_GRBW@#define NEOPIXEL_TYPE          NEO_RGB@w changelog' Marlin/Configuration.h && [ -s changelog ] && grep NEOPIXEL_LED Marlin/Configuration.h

# Melzi screen
#RUN cd /sbase/Marlin && sed -i -e 's@//#define LCD_FOR_MELZI@#define LCD_FOR_MELZI@w changelog' Marlin/Configuration.h && [ -s changelog ]


# RUN cd /sbase/Marlin && sed -i -e 's@//#define MKS_MINI_12864$@#define MKS_MINI_12864@w changelog' Marlin/Configuration.h && [ -s changelog ]
# RUN cd /sbase/Marlin && patch -p0 < ../display.patch


# TFT35
# General options which MUST be activated:
RUN cd /sbase/Marlin && sed -i -e 's@//#define REPRAP_DISCOUNT_FULL_GRAPHIC_SMART_CONTROLLER$@#define REPRAP_DISCOUNT_FULL_GRAPHIC_SMART_CONTROLLER@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define SERIAL_PORT_2 -1$@#define SERIAL_PORT_2 0@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define BABYSTEPPING@#define BABYSTEPPING@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
#RUN cd /sbase/Marlin && sed -i -e 's@//#define AUTO_REPORT_TEMPERATURES@#define AUTO_REPORT_TEMPERATURES@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define AUTO_REPORT_POSITION@#define AUTO_REPORT_POSITION@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define M115_GEOMETRY_REPORT@#define M115_GEOMETRY_REPORT@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define M114_DETAIL@#define M114_DETAIL@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define REPORT_FAN_CHANGE@#define REPORT_FAN_CHANGE@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
# Options to support dialog with host:
RUN cd /sbase/Marlin && sed -i -e 's@//#define EMERGENCY_PARSER@#define EMERGENCY_PARSER@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define SERIAL_FLOAT_PRECISION 4@#define SERIAL_FLOAT_PRECISION 4@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define HOST_ACTION_COMMANDS@#define HOST_ACTION_COMMANDS@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define HOST_PROMPT_SUPPORT@#define HOST_PROMPT_SUPPORT@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
# Options to support M600 with host & (Un)Load menu:
RUN cd /sbase/Marlin && sed -i -e 's@//#define NOZZLE_PARK_FEATURE@#define NOZZLE_PARK_FEATURE@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define ADVANCED_PAUSE_FEATURE@#define ADVANCED_PAUSE_FEATURE@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define PARK_HEAD_ON_PAUSE@#define PARK_HEAD_ON_PAUSE@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define FILAMENT_LOAD_UNLOAD_GCODES@#define FILAMENT_LOAD_UNLOAD_GCODES@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]

# Options to fully support Bed Leveling menu:
RUN cd /sbase/Marlin && sed -i -e 's@//#define Z_MIN_PROBE_REPEATABILITY_TEST@#define Z_MIN_PROBE_REPEATABILITY_TEST@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define G26_MESH_VALIDATION@#define G26_MESH_VALIDATION@w changelog' Marlin/Configuration.h && [ -s changelog ]
RUN cd /sbase/Marlin && sed -i -e 's@//#define Z_STEPPER_AUTO_ALIGN@#define Z_STEPPER_AUTO_ALIGN@w changelog' Marlin/Configuration_adv.h && [ -s changelog ]

RUN cd /sbase/Marlin && platformio run -e LPC1768
