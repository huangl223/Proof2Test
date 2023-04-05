class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs 

	test_ACCOUNT_3_transfer_1
		local 
			current_object: ACCOUNT_3
			amount: INTEGER_32
			other: ACCOUNT_3
		do
			create current_object.make
			create other.make
			{P_INTERNAL}.set_integer_field_ ("balance", current_object, (-2147483599))
				-- current_object.balance = (-2147483599)
			{P_INTERNAL}.set_integer_field_ ("credit_limit", current_object, (-2147483632))
				-- current_object.credit_limit = (-2147483632)
			amount := 33
			{P_INTERNAL}.set_integer_field_ ("balance", other, 7719)
				-- other.balance = 7719
			{P_INTERNAL}.set_integer_field_ ("credit_limit", other, (-2147481211))
				-- other.credit_limit = (-2147481211)
			current_object.transfer (amount, other)
		end

end
