class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs 

	test_BINARY_SEARCH_2_binary_search_1
		local 
			current_object: BINARY_SEARCH_2
			a: V_ARRAY[INTEGER_32]
			value: INTEGER_32
			binary_search_result: INTEGER_32
		do
			create current_object
			create a.make(1, 0)
			a.force(0, 1)
			a.force(0, 2)
			a.force(0, 3)
			a.force((-2147458457), 4)
			a.force((-2147458457), 5)
			a.force((-2147439710), 6)

			value := (-2147458457)
			binary_search_result := current_object.binary_search (a, value)
		end

end
