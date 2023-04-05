class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs 

	test_ACCOUNT_2_withdraw_1
		local 
			current_object: ACCOUNT_2
			amount: INTEGER_32
		do
			create current_object.make
			{P_INTERNAL}.set_integer_field_ ("balance", current_object, 0)
				-- current_object.balance = 0
			{P_INTERNAL}.set_integer_field_ ("credit_limit", current_object, 0)
				-- current_object.credit_limit = 0
			amount := 1
			current_object.withdraw (amount)
		end

end
