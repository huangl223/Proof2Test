class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs 

	test_ACCOUNT_7_transfer_1
		local 
			current_object: ACCOUNT_7
			amount: INTEGER_32
			other: ACCOUNT_7
		do
			create current_object.make
			create other.make
			{P_INTERNAL}.set_integer_field_ ("balance", current_object, 0)
				-- current_object.balance = 0
			{P_INTERNAL}.set_integer_field_ ("credit_limit", current_object, 0)
				-- current_object.credit_limit = 0
			amount := 0
			{P_INTERNAL}.set_integer_field_ ("balance", other, 0)
				-- other.balance = 0
			{P_INTERNAL}.set_integer_field_ ("credit_limit", other, (-7720))
				-- other.credit_limit = (-7720)
			current_object.transfer (amount, other)
		end

end
