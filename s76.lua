-- Controls the S-76C fuel levers with joystick axes.

-- Helper function to find the joystick axis index for a given function.
-- Returns -1 if not found.
local function find_axis_value_index(target_function_index)
    for i = 0, 499 do
        local axis_function_index = get("sim/joystick/joystick_axis_assignments", i)
        if axis_function_index == target_function_index then
            return i
        end
    end
    return -1
end

-- AXIS ASSIGNMENTS
local MIXTURE1_AXIS_INDEX = 28
local MIXTURE2_AXIS_INDEX = 29

local mixture_l_axis_index = find_axis_value_index(MIXTURE1_AXIS_INDEX)
local mixture_r_axis_index = find_axis_value_index(MIXTURE2_AXIS_INDEX)

-- Only run for the S-76C aircraft.
if AIRCRAFT_FILENAME ~= "S-76C.acf" then
    return
end
logMsg("S-76C fuel lever script loaded.")

-- Create global Lua variables linked to the joystick axis datarefs.
DataRef("mixture_L_axis_value", "sim/joystick/joystick_axis_values", "readonly", mixture_l_axis_index)
DataRef("mixture_R_axis_value", "sim/joystick/joystick_axis_values", "readonly", mixture_r_axis_index)

-- Create global Lua variables to automatically detect if the axes are reversed in X-Plane settings.
DataRef("mixture_L_is_reversed", "sim/joystick/joystick_axis_reverse", "readonly", mixture_l_axis_index)
DataRef("mixture_R_is_reversed", "sim/joystick/joystick_axis_reverse", "readonly", mixture_r_axis_index)

-- Find the datarefs for the S-76C's fuel levers.
local fuel_lever_L_ref = XPLMFindDataRef("laminar/s76/controls/fuel_lever_L")
local fuel_lever_R_ref = XPLMFindDataRef("laminar/s76/controls/fuel_lever_R")

-- Check if the datarefs were found.
if fuel_lever_L_ref == nil or fuel_lever_R_ref == nil then
    logMsg("S-76C script ERROR: Could not find fuel lever datarefs. The script will be disabled.")
    return
end

-- This is our main update function.
function s76_mixture_update()
    local axis_L = mixture_L_axis_value
    local axis_R = mixture_R_axis_value

    -- Automatically apply reversal if the axis is reversed in X-Plane settings.
    if mixture_L_is_reversed > 0 then
        axis_L = 1.0 - axis_L
    end
    if mixture_R_is_reversed > 0 then
        axis_R = 1.0 - axis_R
    end

    -- Scale the 0-1 axis value to the 0-3 fuel lever range.
    XPLMSetDataf(fuel_lever_L_ref, axis_L * 3.0)
    XPLMSetDataf(fuel_lever_R_ref, axis_R * 3.0)
end

-- Register our update function to be called on every frame.
do_every_frame("s76_mixture_update()")

logMsg("S-76C fuel lever script is active and will auto-detect reversed axes.")
