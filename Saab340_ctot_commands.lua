-- LES/CMD/CTOT/toggle_L
-- LES/saab/CTOT/toggle_L_pos
-- LES/CMD/CTOT/toggle_R
-- LES/saab/CTOT/toggle_R_pos

ref_ctot_pos_l = XPLMFindDataRef("LES/saab/CTOT/toggle_L_pos")
ref_ctot_pos_r = XPLMFindDataRef("LES/saab/CTOT/toggle_R_pos")

function toggle_ctot()
    command_once("LES/CMD/CTOT/toggle_L")
    command_once("LES/CMD/CTOT/toggle_R")
end

function turn_on_ctot()
    local current_pos = XPLMGetDatai(ref_ctot_pos_l)
    if (current_pos == 0) then
        command_once("LES/CMD/CTOT/toggle_L")
        XPLMSetDatai(ref_ctot_pos_l, 1)
    end
    current_pos = XPLMGetDatai(ref_ctot_pos_r)
    if (current_pos == 0) then
        command_once("LES/CMD/CTOT/toggle_R")
        XPLMSetDatai(ref_ctot_pos_r, 1)
    end
end

function turn_off_ctot()
    local current_pos = XPLMGetDatai(ref_ctot_pos_l)
    if (current_pos == 1) then
        command_once("LES/CMD/CTOT/toggle_L")
        XPLMSetDatai(ref_ctot_pos_l, 0)
    end
    current_pos = XPLMGetDatai(ref_ctot_pos_r)
    if (current_pos == 1) then
        command_once("LES/CMD/CTOT/toggle_R")
        XPLMSetDatai(ref_ctot_pos_r, 0)
    end
end

if string.sub(AIRCRAFT_FILENAME, 1, 13) == "LES_Saab_340A" then
    create_command("FlyWithLua/finlayc/Saab340/ctot_toggle", "toggle L&R CTOT",
    "toggle_ctot()", "", "")

    create_command("FlyWithLua/finlayc/Saab340/ctot_on", "turn L&R CTOT on",
    "turn_on_ctot()", "", "")

    create_command("FlyWithLua/finlayc/Saab340/ctot_off", "turn L&R CTOT off",
    "turn_off_ctot()", "", "")
end