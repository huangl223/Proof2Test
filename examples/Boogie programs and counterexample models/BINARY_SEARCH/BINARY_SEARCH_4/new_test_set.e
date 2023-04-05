class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs 

	test_BINARY_SEARCH_4_binary_search_1
		local 
			current_object: BINARY_SEARCH_4
			a: SIMPLE_ARRAY[INTEGER_32]
			value: INTEGER_32
			binary_search_result: INTEGER_32
		do
			create current_object
			create a.make_empty
			a.force(6, 1)

			value := 6
			binary_search_result := current_object.binary_search (a, value)
		end

end
