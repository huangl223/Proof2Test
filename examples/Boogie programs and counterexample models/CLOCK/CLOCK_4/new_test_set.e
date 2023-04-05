class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs 

	test_CLOCK_4_increase_minutes_1
		local 
			current_object: CLOCK_4
		do
			create current_object.make
			{P_INTERNAL}.set_integer_field_ ("hours", current_object, 23)
				-- current_object.hours = 23
			{P_INTERNAL}.set_integer_field_ ("minutes", current_object, 58)
				-- current_object.minutes = 58
			{P_INTERNAL}.set_integer_field_ ("seconds", current_object, 0)
				-- current_object.seconds = 0
			current_object.increase_minutes
		end

end
