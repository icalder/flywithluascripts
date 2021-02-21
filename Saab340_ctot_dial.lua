-- Assign a joystick axis as 'backup throttle' and it will be used
-- to set ctot dial position

-- les/sf34a/acft/engn/anm/ctot_trq_knob (70.0 - 110.0)
-- les/sf34a/acft/engn/mnp/ctot_trq_knob_up
-- les/sf34a/acft/engn/mnp/ctot_trq_knob_dn

axis_reversed = false
ctot_pos = nil

function find_backup_throttle_axis()
    -- see get_axis_assignments.lua
    local BACKUP_THROTTLE_INDEX = 38
    for i = 0, 499 do
        local axis_function_index = get( "sim/joystick/joystick_axis_assignments", i )
        if axis_function_index == BACKUP_THROTTLE_INDEX then
            if get( "sim/joystick/joystick_axis_reverse", i ) > 0 then
                axis_reversed = true
            end
            return i            
        end        
    end
    return -1
end

function set_ctot()
    current_ctot_pos = XPLMGetDatai(ctot_pos)
    if current_ctot_pos == nil then
        return
    end

    axis_pos = ctot_val
    if axis_reversed then
        axis_pos = 1.0 - axis_pos
    end
    -- ctot dial goes from 0.7 (70%) to 1.1 (110%)
    desired_ctot_pos = math.floor(0.5 + 70 + axis_pos * 40)
    if current_ctot_pos < desired_ctot_pos then
        command_once("les/sf34a/acft/engn/mnp/ctot_trq_knob_up")
    end
    if current_ctot_pos > desired_ctot_pos then
        command_once("les/sf34a/acft/engn/mnp/ctot_trq_knob_dn")
    end
    -- while current_ctot_pos < desired_ctot_pos do
    --     command_once("les/sf34a/acft/engn/mnp/ctot_trq_knob_up")
    --     current_ctot_pos = XPLMGetDataf(ctot_pos)
    -- end
    -- while current_ctot_pos > desired_ctot_pos do
    --     command_once("les/sf34a/acft/engn/mnp/ctot_trq_knob_dn")
    --     current_ctot_pos = XPLMGetDataf(ctot_pos)
    -- end

    --ctot_pos = 70 + axis_pos * 40
    -- ctot_dial = ctot_pos
end

function draw_ctot_info()
    --bubble(10, 10, ctot_val)
    --bubble(10, 10, ctot_dial)    
end    

if string.sub(AIRCRAFT_FILENAME, 1, 13) == "LES_Saab_340A" then
    backup_throttle_axis = find_backup_throttle_axis()
    DataRef("ctot_val", "sim/joystick/joystick_axis_values", "readonly", backup_throttle_axis)
    --DataRef("ctot_dial", "LES/saab/CTOT/dial", "writable")
    --DataRef("ctot_pos", "les/sf34a/acft/engn/anm/ctot_trq_knob", "readonly")
    ctot_pos = XPLMFindDataRef("les/sf34a/acft/engn/anm/ctot_trq_knob")
    do_every_frame("set_ctot()")
    --do_every_draw("draw_ctot_info()")
end
