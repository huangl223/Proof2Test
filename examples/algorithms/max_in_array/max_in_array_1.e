note
    description: "[   Loop invariant max_so_far may not be maintained;
                      incorrect implementation (conditional statement of the if branch) of the loop body.
                  ]"

class
	MAX_IN_ARRAY_1

feature -- Basic operations

	max_in_array (a: SIMPLE_ARRAY [INTEGER]): INTEGER
			-- Find the maximum element of `a'.
		require
			a_element_value: across 1 |..| a.count as c all -2 <= a.sequence [c] and a.sequence [c] <= 10 end
			array_not_empty: a.count > 0 
		local
			i: INTEGER
		do
			Result := a [1]

			from
				i := 2
			invariant
				i_in_bounds: 2 <= i and i <= a.count + 1
				max_so_far: across 1 |..| (i - 1) as c all a.sequence [c] <= Result end
				result_in_array: across 1 |..| (i - 1) as c some a.sequence [c] = Result end
			until
				i = a.count + 1
			loop
				if a [i] < Result then
					Result := a [i]
				end
				i := i + 1
				variant
					a.count - i
			end
		ensure
			is_maximum: across 1 |..| a.count as c all a.sequence [c] <= Result end
			result_in_array: across 1 |..| a.count as c some a.sequence [c] = Result end
		end

end
