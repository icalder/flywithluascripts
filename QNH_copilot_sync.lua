r_MBPlus_QNHPilot   = XPLMFindDataRef("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot")
r_MBPlus_QNHCoPilot = XPLMFindDataRef("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_copilot")

-- we guess the plane has only one barometer, but the user can turn on the copilot's warning 
MBPlus_plane_has_copilot_barometer = false

-- provide a custom command to sync copilot QNH from pilot's altimeter
create_command("FlyWithLua/finlayc/QNHCopilotSync", "sync copilot altimeter to the pilot's",
[[-- sync copilot altimeter (single shot)
XPLMSetDataf(r_MBPlus_QNHCoPilot, XPLMGetDataf(r_MBPlus_QNHPilot))
XPLMSpeakString("Copilot altimeter synced!")]],
"", -- do nothing if the button is hold down
"") -- do nothing if the button is released