class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs

	test_BINARY_SEARCH_5_binary_search_1
		local
			current_object: BINARY_SEARCH_5
			a: V_ARRAY[INTEGER_32]
			value: INTEGER_32
			binary_search_result: INTEGER_32
		do
			create current_object
			create a.make(1, 0)
			a.force((-2147470858), 1)
			a.force((-2147470858), 2)
			a.force((-2147470858), 3)
			a.force((-2147470858), 4)
			a.force((-2147470858), 5)
			a.force((-2147470858), 6)
			a.force((-2147467706), 7)

			value := (-2147467706)
			binary_search_result := current_object.binary_search (a, value)
		end

end
