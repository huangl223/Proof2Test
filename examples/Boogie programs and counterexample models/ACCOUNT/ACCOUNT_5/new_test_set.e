class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs 

	test_ACCOUNT_5_transfer_1
		local 
			current_object: ACCOUNT_5
			amount: INTEGER_32
			other: ACCOUNT_5
		do
			create current_object.make
			{P_INTERNAL}.set_integer_field_ ("balance", current_object, (-2147481210))
				-- current_object.balance = (-2147481210)
			{P_INTERNAL}.set_integer_field_ ("credit_limit", current_object, (-2147482752))
				-- current_object.credit_limit = (-2147482752)
			amount := 1542
			other := current_object
			current_object.transfer (amount, other)
		end

end
