# Project Overview

This directory contains a collection of Lua scripts for the X-Plane flight simulator, designed to be used with the FlyWithLua plugin. These scripts provide custom commands and automation for various aircraft, enhancing the simulation experience.

# Scripts

## QNH Scripts

*   **`QNH_copilot_sync.lua`**: Creates a command to synchronize the copilot's altimeter setting (QNH) with the pilot's.
*   **`QNH_helper.lua`**: Displays the current QNH in both inHg and hPA for a few seconds whenever the pilot's QNH is changed. This script is active for the BN-2 Islander and the LES Saab 340A.

## Saab 340A Scripts

These scripts are for the LES Saab 340A aircraft.

*   **`Saab340_ctot_commands.lua`**: Provides commands to toggle, turn on, and turn off the CTOT (Constant Torque on Takeoff) system.
*   **`Saab340_ctot_dial.lua`**: Allows the user to control the CTOT torque dial using a joystick axis (specifically, the axis assigned to "backup throttle").
*   **`Saab340_lights_commands.lua`**: Provides commands to control the taxi, strobe, and landing lights.
*   **`Saab340_prop_commands.lua`**: Provides commands to control the propeller sync and autocoarsen systems.

## S-76C Script

*   **`s76.lua`**: This script appears to be for the S-76C helicopter and is likely related to engine mixture controls.

# Development Conventions

Important: when generating code, only use Lua constructs that are compatible with X-Plane and the FlyWithLua plugin.

The scripts use the FlyWithLua API to interact with X-Plane. They define custom commands and use `do_every_frame` or `do_every_draw` for continuous actions. DataRefs are used to read and write data from the simulator. The scripts are organized by aircraft and function.
