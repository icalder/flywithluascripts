-- This script helps you find the index of your joystick axes by using the DataRef function.
-- It now checks for axes up to index 199.

logMsg("Find My Axes (DataRef method, very high limit) script loaded. Open your Log.txt file.")

-- Create a global variable for each axis, up to 200.
for i = 0, 499 do
    DataRef("axis_" .. i, "sim/joystick/joystick_axis_values", "readonly", i)
end

local last_run_time = 0

function check_axes_values()
    local current_time = os.clock()
    if current_time - last_run_time < 2.0 then
        return
    end
    last_run_time = current_time

    logMsg("--- Axis Report (searching up to index 199) ---")
    local found_moved_axis = false

    for i = 0, 499 do
        -- Access the global variable by its name
        local value = _G["axis_" .. i]
        
        if value ~= nil and (value > 0.02 or value < -0.02) then
            local line = string.format("Moved Axis -> Index %d: Value = %.2f", i, value)
            logMsg(line)
            found_moved_axis = true
        end
    end

    if not found_moved_axis then
        logMsg("No moved axes detected at this time.")
    end
end

-- Register our checking function to be called every frame.
do_every_frame("check_axes_values()")