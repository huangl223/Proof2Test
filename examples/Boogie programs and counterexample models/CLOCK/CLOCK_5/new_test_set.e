class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs 

	test_CLOCK_5_increase_seconds_1
		local 
			current_object: CLOCK_5
		do
			create current_object.make
			{P_INTERNAL}.set_integer_field_ ("hours", current_object, 15)
				-- current_object.hours = 15
			{P_INTERNAL}.set_integer_field_ ("minutes", current_object, 58)
				-- current_object.minutes = 58
			{P_INTERNAL}.set_integer_field_ ("seconds", current_object, 59)
				-- current_object.seconds = 59
			current_object.increase_seconds
		end

end
