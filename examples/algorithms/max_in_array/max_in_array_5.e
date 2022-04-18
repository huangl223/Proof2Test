note
	description: "Algorithm to find the maximum value of an array."

class
	MAX_IN_ARRAY_5

feature -- Basic operations

	max_in_array (a: SIMPLE_ARRAY [INTEGER]): INTEGER
			-- Find the maximum element of `a'.
		require
			array_not_empty: a.count > 0
		local
			i: INTEGER
			-- @  a = <<3, 7, 8>>
		do
			Result := a[1]
			from
				i := 2
					-- @ Result = 3, i = 2
			invariant
				i_in_bounds: 2 <= i and i <= a.count + 1
				max_so_far: across 1 |..| (i - 1)  as c all a.sequence [c] <= Result end
				result_in_array: across 1 |..| (i - 1) as c some a.sequence [c] = Result end
			until
				i > a.count
				-- @ 1st loop iteration i = 2, a.count = 3
				-- @ 2nd loop iteration i = 3, a.count = 3, iteration ends
			loop
				if a [i] < Result then
					Result := a [i]
						-- @ 1st iteration Result = 7
				end
				i := i + 1
					-- @ 1st iteration i = 3
			variant
				a.count - i
			end
		ensure
				-- @ a = <<3, 7, 8>>, Result = 7
			is_maximum: across 1 |..| a.count as c all a.sequence [c] <= Result end
			result_in_array: across 1 |..| a.count as c some a.sequence [c] = Result end
		end

end
