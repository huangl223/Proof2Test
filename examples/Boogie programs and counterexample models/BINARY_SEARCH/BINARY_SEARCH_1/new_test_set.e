class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs 

	test_BINARY_SEARCH_1_binary_search_1
		local 
			current_object: BINARY_SEARCH_1
			a: V_ARRAY[INTEGER_32]
			value: INTEGER_32
			binary_search_result: INTEGER_32
		do
			create current_object
			create a.make(1, 0)
			a.force(0, 1)
			a.force(2147457740, 2)

			value := 2147457741
			binary_search_result := current_object.binary_search (a, value)
		end

end
