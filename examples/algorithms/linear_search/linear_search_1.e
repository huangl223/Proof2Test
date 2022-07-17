note
	description: "Linear search in integer arrays."

class
	LINEAR_SEARCH_1

feature -- Basic operations

	linear_search (a: V_ARRAY [INTEGER]; value: INTEGER): INTEGER
			-- Index of `value' in `a' using linear search starting from end of array.
			-- https://en.wikipedia.org/wiki/Linear_search#Searching_in_reverse_order
		require
			a_not_empty: a.count > 0
			a_size_limit: a.count <= 3
			valid_index: a.lower < a.upper
			a_element_value: across 1 |..| a.count as c all 0 <= a.sequence[c] and a.sequence[c] <= 10 end
			-- @ a -> <<10>>, value -> 9
		do
			from
				Result := a.upper
				--  @ Result -> 1
			invariant

				across (Result - a.lower + 2) |..| a.count as i all a.sequence[i] /= value end
				-- @ 1 st iteration: Result -> 1, a -> <<10>>, a.count -> 1, value -> 9
			until
				Result = a.lower  or else a[Result] = value
				-- @ Result -> 1, a -> <<10>>, value -> 9, iteration ends
			loop
				Result := Result - 1
			variant
				Result - a.lower
			end
		ensure
			-- @ a -> <<10>>, value -> 9, Result -> 1
			present: a.sequence.has (value) = (Result >= a.lower and Result <= a.upper)
			not_present: not a.sequence.has (value) = (Result = a.lower - 1)
			found_if_present: (Result >= a.lower and Result <= a.upper) implies a.sequence[Result - a.lower + 1] = value
			first_from_back: across (Result - a.lower + 2) |..| a.count as i all a.sequence[i] /= value end

		end

end
