-- cp .\ap.lua C:\Users\iainc\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Scripts\
SimVar("sim/cockpit/autopilot/autopilot_state")
function get_ias_mode()
    local ap_state = SimRead("sim/cockpit/autopilot/autopilot_state")
    return (ap_state & 0x8) > 0 and 1 or 0
end
