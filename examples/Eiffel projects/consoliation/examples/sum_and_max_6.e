note
	description: "Algorithm to calculate sum and maximum of an integer array."

class
	SUM_AND_MAX_6

feature

	sum_and_max (a: SIMPLE_ARRAY [INTEGER]): TUPLE [sum, max: INTEGER]
			-- Calculate sum and maximum of array `a'.
		require
			a_not_void: a /= Void
			natural_numbers: ∀ ai: 1 |..| a.count ¦ a.sequence [ai] >= 0
			-- array_not_empty: a.count > 0
		local
			i: INTEGER
			sum, max: INTEGER
		do
			from
				i := 1
				-- i := 2; max := a[1]; sum := a[1]
			invariant
				i_in_range: 1 <= i and i <= a.count + 1
				sum_and_max_not_negative: sum >= 0 and max >= 0
				-- partial_sum_and_max: sum <= (i - 1) * max
				max_so_far: ∀ ai: 1 |..| (i-1) ¦ max >= a.sequence [ai]

			until
				i > a.count
			loop
				if a [i] > max then
					max := a [i]
				end
				sum := sum + a [i]
				i := i + 1
			end
			Result := [sum, max]
		ensure
			sum_in_range: Result.sum <= a.count * Result.max
			is_maximum: ∀ ai: 1 |..| a.count ¦ Result.max >= a.sequence [ai]
			modify()
		end

end
