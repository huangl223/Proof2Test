class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs 

	test_HEATER_1_turn_on_off_1
		local 
			current_object: HEATER_1
		do
			create current_object.make
			{P_INTERNAL}.set_integer_field_ ("desired_temp", current_object, 10)
				-- current_object.desired_temp = 10
			{P_INTERNAL}.set_boolean_field_ ("is_on", current_object, false)
				-- current_object.is_on = false
			{P_INTERNAL}.set_integer_field_ ("temperature", current_object, 8)
				-- current_object.temperature = 8
			current_object.turn_on_off
		end

end
