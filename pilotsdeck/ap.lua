-- cp .\ap.lua C:\Users\iainc\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Scripts\
SimVar("sim/cockpit/autopilot/autopilot_state")
SimVar("sim/cockpit2/autopilot/altitude_dial_ft")
SimVar("sim/cockpit/autopilot/heading")
SimVar("sim/cockpit/radios/nav1_obs_degm")

function get_hdg_mode()
    local ap_state = SimRead("sim/cockpit/autopilot/autopilot_state")
    return (ap_state & 0x2) > 0 and 1 or 0
end

function get_ias_mode()
    local ap_state = SimRead("sim/cockpit/autopilot/autopilot_state")
    return (ap_state & 0x8) > 0 and 1 or 0
end

function change_selected_altitude(value)
    local current_alt = SimRead("sim/cockpit2/autopilot/altitude_dial_ft")
    local target = current_alt + value
    SimWrite("sim/cockpit2/autopilot/altitude_dial_ft", target)
end

function change_selected_heading(value)
    local cmd = (value > 0) and "sim/autopilot/heading_up" or "sim/autopilot/heading_down"
    local current_hdg = SimRead("sim/cockpit/autopilot/heading")
    local target = (current_hdg + value) % 360

    local function angular_distance(a, b)
        local diff = (b - a + 540) % 360 - 180
        return diff
    end

    while true do
        local dist = angular_distance(current_hdg, target)
        -- Stop if we've reached or passed the target in the intended direction
        if (value > 0 and dist <= 0) or (value < 0 and dist >= 0) then
            break
        end
        SimCommand(cmd)
        Sleep(10)
        current_hdg = SimRead("sim/cockpit/autopilot/heading")
    end
end

function change_obs1(value)
    local cmd = (value > 0) and "sim/radios/obs1_up" or "sim/radios/obs1_down"
    local current_obs = SimRead("sim/cockpit/radios/nav1_obs_degm")
    local target = (current_obs + value) % 360

    local function angular_distance(a, b)
        local diff = (b - a + 540) % 360 - 180
        return diff
    end

    while true do
        local dist = angular_distance(current_obs, target)
        -- Stop if we've reached or passed the target in the intended direction
        if (value > 0 and dist <= 0) or (value < 0 and dist >= 0) then
            break
        end
        SimCommand(cmd)
        Sleep(10)
        current_obs = SimRead("sim/cockpit/radios/nav1_obs_degm")
    end
end
