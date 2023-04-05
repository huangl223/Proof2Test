class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs 

	test_SQUARE_ROOT_2_square_root_1
		local 
			current_object: SQUARE_ROOT_2
			n: INTEGER_32
			square_root_result: TUPLE[INTEGER_32,INTEGER_32]
		do
			create current_object
			n := 0
			square_root_result := current_object.square_root (n)
		end

end
