class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs 

	test_LAMP_1_turn_on_off_1
		local 
			current_object: LAMP_1
		do
			create current_object
			{P_INTERNAL}.set_boolean_field_ ("is_on", current_object, true)
				-- current_object.is_on = true
			{P_INTERNAL}.set_integer_field_ ("light_intensity", current_object, 75)
				-- current_object.light_intensity = 75
			{P_INTERNAL}.set_integer_field_ ("previous_light_intensity", current_object, 0)
				-- current_object.previous_light_intensity = 0
			current_object.turn_on_off
		end

end
