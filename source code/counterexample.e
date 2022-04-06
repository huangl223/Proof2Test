note
	description: "This class parses the input .model file to collect information for test generation."
	author: "Li Huang"
	date: "$2022-03-22$"
	revision: "$1.0$"

class
	COUNTEREXAMPLE

create
	make

feature {NONE} -- Initialization

	make (model: STRING_32)
			-- Initialization
		do
			create constants_values.make (0)
			create heap_function.make (0)
			create seq_item.make (0)
			create seq_lengths.make (0)
			create class_field_relations.make (0)

			class_name := ""
			routine_name := ""

			line_index := 1
			model_lines := model.split ('%N')

			get_constants_values
			get_heap_function

			if model.has_substring ("sequence") then
				get_sequence_elements
				get_sequence_lengths
			end

			get_routine_and_class_name
		end

feature  -- Colleted data

	model_lines: LIST [STRING_32]
			-- Model in lines

	line_index: INTEGER
			-- The current line position

	routine_name: IMMUTABLE_STRING_32
			-- Target routine

	class_name: IMMUTABLE_STRING_32
			-- Target class

	constants_values: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Mapping from constants to values

	class_field_relations: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Mapping from class.field to an abstract value

	heap_function: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Interpretation of a function that represents the heap behavior: [heap state, object, field] -> value

	seq_item: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Sequences' elements

	seq_lengths: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Sequences's lengths

feature  -- Parse model 

	safe_name (name: STRING_32): STRING_32
			-- Get a valid name
		do
			if name.has_substring ("@@") then
				Result := name.split ('@').first
			elseif name.same_string ("Current") then
				Result := "current_object"
			else
				Result := name
			end
		end

	get_constants_values
			-- Collect the values of constants in the model
		local
			name, value, line: STRING_32
			words: LIST [STRING_32]
		do
			line := ""; name := ""; value := "";

			from
				line_index := 1
			until
				end_of_model_file or else model_lines [line_index].has_substring ("{")
			loop
				line.copy (model_lines [line_index])

				if line.has_substring ("->") then
					words := line.split (' ')
					name.copy (safe_name (words [1]))

					value.copy (words [3])

					if words [3].has ('(') then
						value.append (words [4])
					end

					if name.has_substring (".") then
						class_field_relations [name] := ""
						class_field_relations [name].copy (value)
					else
						constants_values [name] := ""
						constants_values [name].copy (value)
					end

				end
				read_next_line
			end
		end

	get_heap_function
			-- Construct a hash table for ``Select'' function
		local
			line, value: STRING_32
			words: LIST [STRING_32]
		do
			line := ""; value := ""
			from
			until
				end_of_model_file or model_lines [line_index].has_substring ("MapType0Select")
			loop
				read_next_line

			end

			from
				read_next_line
			until
				end_of_model_file or else model_lines [line_index].has_substring ("}")
			loop
				if model_lines [line_index].has_substring (constants_values ["Heap"]) then
					line.copy (model_lines [line_index])
					words := line.split (' ')
					heap_function [words [4] + ", " + words [5]] := ""
					value.copy (words [7])

					if words [7].has ('(') then
						value.append (words [8])
					end
					heap_function [words [4] + ", " + words [5]].copy (value)

				end
				read_next_line
			end

		end

	get_sequence_elements
			-- Collect the elements of sequences
		local
			line, value, key: STRING_32
			words: LIST [STRING_32]
		do
			line := ""; value := ""; key := ""

			from
			until
				end_of_model_file or model_lines [line_index].has_substring ("Seq#Item")
			loop
				read_next_line
			end

			from
				read_next_line
			until
				end_of_model_file or else model_lines [line_index].has_substring ("}")
			loop
				line.copy (model_lines [line_index])

				words := line.split (' ')
				if words [3].same_string ("else") then
					key.copy ("else")
					value.copy (words [5])
					if value.has_substring ("(") then
						value.append (words [6])
					end
				elseif words.count >= 5 then
					key.copy (words [3] + ", " + words [4])
					if words [4].has ('(') then
						key.append (words [5])
						value.copy (words [7])
						if value.has_substring ("(") then
						    value.append (words [8])
					    end
					else
					    value.copy (words [6])
					    if value.has_substring ("(") then
						    value.append (words [7])
					    end
					end

				end


				seq_item.extend (value, key)
				read_next_line
			end
		end

	get_sequence_lengths
			-- Collect the lengths of sequences
		local
			line, value, key: STRING_32
			words: LIST [STRING_32]
		do
			line := ""; value := ""; key := ""

			from
			until
				end_of_model_file or else model_lines [line_index].has_substring ("Seq#Length")
			loop
				read_next_line
			end

			from
				read_next_line
			until
				end_of_model_file or else model_lines [line_index].has_substring ("}")
			loop
				line.copy (model_lines [line_index])
				if not line.has_substring ("else") then
					words := line.split (' ')
					seq_lengths.extend (words [5], words [3])
				end
				read_next_line
			end
		end

	read_next_line
			-- Increase the line index by 1
		do
			line_index := line_index + 1
		end

	end_of_model_file: BOOLEAN
			-- Is the end of the model file?
		do
			Result := (line_index >= model_lines.count)
		end

	get_routine_and_class_name
			-- Collect the name of the target routine and target class
		local
			line: STRING_32
		do
			line := ""
			from
			until
				end_of_model_file
			loop
				if model_lines [line_index].has_substring ("*** STATE") then
					line.copy (model_lines [line_index])
					class_name.copy (line.split (' ').last.split ('.').first)
					routine_name.copy (line.split (' ').last.split ('.').last)
				end
				read_next_line
			end
		end

end

