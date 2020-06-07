-- prop sync
ref_prop_sync_toggle = XPLMFindDataRef("LES/saab/prop/prop_sync_toggle")

function turn_on_prop_sync()
    XPLMSetDatai(ref_prop_sync_toggle, 1)
end

function turn_off_prop_sync()
    XPLMSetDatai(ref_prop_sync_toggle, 0)
end

-- auto coarsen
ref_autocoarsen_pos = XPLMFindDataRef("LES/saab/OH/autocoarsen_toggle_pos")

function turn_on_autocoarsen()
    local current_pos = XPLMGetDatai(ref_autocoarsen_pos)
    if (current_pos == 0) then
        command_once("LES/CMD/engine/overhead/auto_coarsen_toggle")
        XPLMSetDatai(ref_autocoarsen_pos, 1)
    end
end

function turn_off_autocoarsen()
    local current_pos = XPLMGetDatai(ref_autocoarsen_pos)
    if (current_pos == 1) then
        command_once("LES/CMD/engine/overhead/auto_coarsen_toggle")
        XPLMSetDatai(ref_autocoarsen_pos, 0)
    end
end

if string.sub(AIRCRAFT_FILENAME, 1, 13) == "LES_Saab_340A" then
    create_command("FlyWithLua/finlayc/Saab340/prop_sync_on", "turn prop sync on",
    "turn_on_prop_sync()", "", "")

    create_command("FlyWithLua/finlayc/Saab340/prop_sync_off", "turn prop sync off",
    "turn_off_prop_sync()", "", "")

    create_command("FlyWithLua/finlayc/Saab340/autocoarsen_on", "turn autocoarsen on",
    "turn_on_autocoarsen()", "", "")

    create_command("FlyWithLua/finlayc/Saab340/autocoarsen_off", "turn autocoarsen off",
    "turn_off_autocoarsen()", "", "")
end    