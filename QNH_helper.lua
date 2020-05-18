DataRef( "QNH_Pilot", "sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot" )
last_QNH_Pilot = QNH_Pilot
QNH_display_end_time = os.clock()

function QNH_helper()
	-- if the QNH setting has changed, we want to display the info for 2 sec
	if QNH_Pilot ~= last_QNH_Pilot then
		QNH_display_end_time = os.clock() + 2.0
	end
	-- we place the info above the mouse pointer
	if os.clock() < QNH_display_end_time then
		msg = string.format("%.2f inHg is %d hPA", math.floor( (QNH_Pilot * 100) + 0.5) / 100, math.floor(QNH_Pilot * 33.8637526 + 0.5))		
		big_bubble(MOUSE_X, MOUSE_Y, msg)
		last_QNH_Pilot = QNH_Pilot
	end
end

-- PLANE_ICAO BN2P
-- AIRCRAFT_FILENAME LES_Saab_340A.acf LES_Saab_340A_Cargo.acf
if PLANE_ICAO == "BN2P" or string.sub(AIRCRAFT_FILENAME, 1, 13) == "LES_Saab_340A" then
	do_every_draw("QNH_helper()")
end