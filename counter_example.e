note
	description: "TestGen application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	COUNTER_EXAMPLE

create
	make

feature {NONE} -- Initialization

	make (mdl: STRING_32)
			-- Run application.
		do
			create constants.make (0)
			create heap_function.make (0)
			create initial_values.make (0)
			create seq_item.make (0)
			create seq_lengths.make (0)
			class_name := ""
			routine_name := ""

			current_line := 1
			model_lines := mdl.split ('%N')
			print ("model size: " + model_lines.count.out + "%N")

			get_initial_values
			get_constants
			get_heap_function

			if mdl.has_substring ("sequence") then
					-- get the values of sequence
				get_sequence_elements
				get_sequence_lengths
			end

			get_routine_and_class_name
		end

feature

	model_lines: LIST [STRING_32]
			-- Read model line by line

	current_line: INTEGER
			-- The current line position

	routine_name: IMMUTABLE_STRING_32
			-- Current routine

	class_name: IMMUTABLE_STRING_32
			-- Current class

	constants: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Mapping from variables to abstract values

	initial_values: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Mapping from argument to its value

	heap_function: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Mapping function that represents the heap

	seq_item: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Store the value of array

	seq_lengths: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- The lengths of arrays

feature

	get_constants
	    -- Collect the value of constants
		local
			v: STRING_32

			u: STRING_32

			line: STRING_32

			words: LIST [STRING_32]
		do
			line := ""
			v := ""
			u := ""

			from
				current_line := 3
			until
				current_line >= model_lines.count or else model_lines [current_line].has_substring ("writable")
			loop
				line.copy (model_lines [current_line])
					-- print ("constants line: " + line + "%N")
				if line.has_substring ("->") then
					words := line.split (' ')
					constants [words [1]] := ""
					v.copy (words [3])

					if words [3].has ('(') then -- if the value is a negative number
						v.append (words [4])
					end
					constants [words [1]].copy (v)

				end
				current_line := current_line + 1
			end
		end

	get_heap_function
	    -- Construct hash table for ``Select'' function
		local
			line: STRING_32
			words: LIST [STRING_32]
			value: STRING_32
		do
			line := ""
			value := ""
			from current_line := current_line + 1
			until model_lines [current_line].has_substring ("MapType0Select")
			loop current_line := current_line + 1 end

			from
				current_line := current_line + 1
			until
				current_line >= model_lines.count or else model_lines [current_line].has_substring ("else")
			loop
				if model_lines [current_line].has_substring (initial_values ["Heap"]) then -- TODO: change into argument
					line.copy (model_lines [current_line])
					words := line.split (' ')
					heap_function [words [4] + ", " + words [5]] := ""
					value.copy (words [7])

						-- TODO: deal with missing values
					if words [7].has ('(') then -- compound element
						value.append (words [8])
					end
					heap_function [words [4] + ", " + words [5]].copy (value)

				end
				current_line := current_line + 1
			end
		end

	get_sequence_elements
        -- Collect the elements of sequences
		local
			line: STRING_32
			words: LIST [STRING_32]
			value: STRING_32
			key: STRING_32
		do
			line := ""
			value := ""
			key := ""

			from
				current_line := 1
			until
				model_lines [current_line].has_substring ("Seq#Item") or current_line >= model_lines.count
			loop
				current_line := current_line + 1
			end

			from
				current_line := current_line + 1
			until
				current_line >= model_lines.count or else model_lines [current_line].has_substring ("}")
			loop
				line.copy (model_lines [current_line])
				words := line.split (' ')
				if words [3].same_string ("else") then
					key.copy ("else")
					value.copy (words [5])
					if value.has_substring ("(") then
						value.append (words [6])
					end
				elseif words.count >= 5 then
					key.copy (words [3] + ", " + words [4])
						value.copy (words [6])
						if value.has_substring ("(") then
							value.append (words [7])
						end
				end
				seq_item.extend (value, key)
				current_line := current_line + 1
			end
		end

	get_sequence_lengths
	    -- Collect the lengths of sequences
		local
			line: STRING_32
			words: LIST [STRING_32]
			value: STRING_32
			key: STRING_32
		do
			line := ""
			value := ""
			key := ""

			from
				current_line := 1
			until
				current_line >= model_lines.count or else model_lines [current_line].has_substring ("Seq#Length")
			loop
				current_line := current_line + 1
			end

			from
				current_line := current_line + 1
			until
				current_line >= model_lines.count or else model_lines [current_line].has_substring ("else")
			loop
				line.copy (model_lines [current_line])
				words := line.split (' ')
				seq_lengths.extend (words [5], words [3])
				current_line := current_line + 1
			end

		end

	get_initial_values
			-- Extract info from ``initial state'' TODO: remove this function, use the constants value directly.
		local
			line: STRING_32
			words: LIST [STRING_32]
			argument_name: STRING_32
			argument_value: STRING_32

		do
			line := ""
			argument_name := ""
			argument_value := ""

			from
				current_line := 1
			until
				current_line >= model_lines.count or else model_lines [current_line].has_substring ("<initial>")
			loop
				current_line := current_line + 1
			end

			from
				current_line := current_line + 1
			until
				current_line >= model_lines.count or else model_lines [current_line].has_substring ("END_STATE")
			loop
				line.copy (model_lines [current_line])
				words := line.split (' ')
				argument_name.copy (words [3])
				if words.count > 4 then
					argument_value.copy (words [5])
				else
						-- TODO: if the information is not complete, create a message to notify
				end
				if words [5].has ('(') then -- compound element
					argument_value.append (words [6])
				end

				initial_values.extend (argument_value, argument_name)
				current_line := current_line + 1
			end
		end

	get_routine_and_class_name
	    -- Collect the name of the target routine and target class
		local
			line: STRING_32
		do
			line := ""
			if current_line >= model_lines.count then
				current_line := 0
			end

			from
				current_line := current_line + 1
			until
				current_line >= model_lines.count
			loop
				if model_lines [current_line].has_substring ("*** STATE") then
					line.copy (model_lines [current_line])
					class_name.copy (line.split (' ').last.split ('.').first)
					routine_name.copy (line.split (' ').last.split ('.').last)
				end
				current_line := current_line + 1
			end

		end

end

