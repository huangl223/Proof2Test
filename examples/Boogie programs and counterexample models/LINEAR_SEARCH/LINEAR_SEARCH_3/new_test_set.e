class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs 

	test_LINEAR_SEARCH_3_linear_search_1
		local 
			current_object: LINEAR_SEARCH_3
			a: SIMPLE_ARRAY[INTEGER_32]
			value: INTEGER_32
			linear_search_result: INTEGER_32
		do
			create current_object
			create a.make_empty
			a.force(0, 1)
			a.force((-2147462410), 2)

			value := (-2147462410)
			linear_search_result := current_object.linear_search (a, value)
		end

end