class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs 

	test_CLOCK_1_increase_hours_1
		local 
			current_object: CLOCK_1
		do
			create current_object.make
			{P_INTERNAL}.set_integer_field_ ("hours", current_object, 23)
				-- current_object.hours = 23
			{P_INTERNAL}.set_integer_field_ ("minutes", current_object, 39)
				-- current_object.minutes = 39
			{P_INTERNAL}.set_integer_field_ ("seconds", current_object, 38)
				-- current_object.seconds = 38
			current_object.increase_hours
		end

end
