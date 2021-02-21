-- taxi light
ref_taxi_light_pos = XPLMFindDataRef("les/sf34a/acft/ltng/anm/taxi_lights_switch")

function turn_on_taxi_light()
    local current_pos = XPLMGetDatai(ref_taxi_light_pos)
    if (current_pos == 0) then        
        command_once("les/sf34a/acft/ltng/mnp/taxi_lights_switch")
        XPLMSetDatai(ref_taxi_light_pos, 1)
    end
end

function turn_off_taxi_light()
    local current_pos = XPLMGetDatai(ref_taxi_light_pos)
    if (current_pos == 1) then
        command_once("les/sf34a/acft/ltng/mnp/taxi_lights_switch")
        XPLMSetDatai(ref_taxi_light_pos, 0)
    end
end

-- strobe lights
ref_strobe_light_pos = XPLMFindDataRef("les/sf34a/acft/ltng/anm/strobe_lights_switch")

function turn_on_strobe_lights()
    local current_pos = XPLMGetDatai(ref_strobe_light_pos)
    if (current_pos == 0) then
        command_once("les/sf34a/acft/ltng/mnp/strobe_lights_switch")
        XPLMSetDatai(ref_strobe_light_pos, 1)
    end
end

function turn_off_strobe_lights()
    local current_pos = XPLMGetDatai(ref_strobe_light_pos)
    if (current_pos == 1) then
        command_once("les/sf34a/acft/ltng/mnp/strobe_lights_switch")
        XPLMSetDatai(ref_strobe_light_pos, 0)
    end
end

-- -- landing lights
ref_landing_light_pos_l = XPLMFindDataRef("les/sf34a/acft/ltng/anm/landing_lights_switch_L")
ref_landing_light_pos_r = XPLMFindDataRef("les/sf34a/acft/ltng/anm/landing_lights_switch_R")

function turn_on_landing_lights()
    local current_pos = XPLMGetDatai(ref_landing_light_pos_l)
    if (current_pos == 0) then
        command_once("les/sf34a/acft/ltng/mnp/landing_lights_switch_L")
        XPLMSetDatai(ref_landing_light_pos_l, 1)
    end
    current_pos = XPLMGetDatai(ref_landing_light_pos_r)
    if (current_pos == 0) then
        command_once("les/sf34a/acft/ltng/mnp/landing_lights_switch_R")
        XPLMSetDatai(ref_landing_light_pos_r, 1)
    end
end

function turn_off_landing_lights()
    local current_pos = XPLMGetDatai(ref_landing_light_pos_l)
    if (current_pos == 1) then
        command_once("les/sf34a/acft/ltng/mnp/landing_lights_switch_L")
        XPLMSetDatai(ref_landing_light_pos_l, 0)
    end
    current_pos = XPLMGetDatai(ref_landing_light_pos_r)
    if (current_pos == 1) then
        command_once("les/sf34a/acft/ltng/mnp/landing_lights_switch_R")
        XPLMSetDatai(ref_landing_light_pos_r, 0)
    end
end

if string.sub(AIRCRAFT_FILENAME, 1, 13) == "LES_Saab_340A" then
    create_command("FlyWithLua/finlayc/Saab340/taxi_light_on", "turn taxi light on",
    "turn_on_taxi_light()", "", "")
    
    create_command("FlyWithLua/finlayc/Saab340/taxi_light_off", "turn taxi light off",
    "turn_off_taxi_light()", "", "")

    create_command("FlyWithLua/finlayc/Saab340/strobe_lights_on", "turn strobe lights on",
    "turn_on_strobe_lights()", "", "")

    create_command("FlyWithLua/finlayc/Saab340/strobe_lights_off", "turn strobe lights off",
    "turn_off_strobe_lights()", "", "")

    create_command("FlyWithLua/finlayc/Saab340/landing_lights_on", "turn L&R landing lights on",
    "turn_on_landing_lights()", "", "")

    create_command("FlyWithLua/finlayc/Saab340/landing_lights_off", "turn L&R landing lights off",
    "turn_off_landing_lights()", "", "")
end