ref_ctot_pos_l = XPLMFindDataRef("les/sf34a/acft/engn/anm/ctot_switch_L")
ref_ctot_pos_r = XPLMFindDataRef("les/sf34a/acft/engn/anm/ctot_switch_R")

function toggle_ctot()
    command_once("les/sf34a/acft/engn/mnp/ctot_switch_L")
    command_once("les/sf34a/acft/engn/mnp/ctot_switch_R")
end

function turn_on_ctot()
    local current_pos = XPLMGetDatai(ref_ctot_pos_l)
    if (current_pos == 0) then
        command_once("les/sf34a/acft/engn/mnp/ctot_switch_L")
        XPLMSetDatai(ref_ctot_pos_l, 1)
    end
    current_pos = XPLMGetDatai(ref_ctot_pos_r)
    if (current_pos == 0) then
        command_once("les/sf34a/acft/engn/mnp/ctot_switch_R")
        XPLMSetDatai(ref_ctot_pos_r, 1)
    end
end

function turn_off_ctot()
    local current_pos = XPLMGetDatai(ref_ctot_pos_l)
    if (current_pos == 1) then
        command_once("les/sf34a/acft/engn/mnp/ctot_switch_L")
        XPLMSetDatai(ref_ctot_pos_l, 0)
    end
    current_pos = XPLMGetDatai(ref_ctot_pos_r)
    if (current_pos == 1) then
        command_once("les/sf34a/acft/engn/mnp/ctot_switch_R")
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