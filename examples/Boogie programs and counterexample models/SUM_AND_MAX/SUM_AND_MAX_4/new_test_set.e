class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs 

	test_SUM_AND_MAX_4_sum_and_max_1
		local 
			current_object: SUM_AND_MAX_4
			a: SIMPLE_ARRAY[INTEGER_32]
			sum_and_max_result: TUPLE[INTEGER_32,INTEGER_32]
		do
			create current_object
			create a.make_empty
			a.force(1, 1)
			a.force(1, 2)

			sum_and_max_result := current_object.sum_and_max (a)
		end

end
