class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs 

	test_MAX_IN_ARRAY_2_max_in_array_1
		local 
			current_object: MAX_IN_ARRAY_2
			a: SIMPLE_ARRAY[INTEGER_32]
			max_in_array_result: INTEGER_32
		do
			create current_object
			create a.make_empty
			a.force((-2147455548), 1)
			a.force((-2147455548), 2)
			a.force(11798, 3)
			a.force(0, 4)

			max_in_array_result := current_object.max_in_array (a)
		end

end
