note
	description: "This class extracts context information from the input .bpl file."
	author: "Li Huang"
	date: "$2022-03-22$"
	revision: "$1.0$"

class
	PROOF_CONTEXT

create
	make

feature  -- Initialize	
	make (a_bpl_lines: ARRAY [IMMUTABLE_STRING_32]; error_routines: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32])
			-- Initialization
		do
			create routines_arguments.make (0)
			create result_types.make (0)
			create class_fields.make (0)
			create fields_types.make (0)
			create routines_arguments.make (0)
			create creation_procedures.make (0)
			create arguments_types.make (0)

			line_index := 1
			bpl_lines := a_bpl_lines

			get_verification_context (error_routines)

		end

feature -- Collected data

	bpl_lines: ARRAY [IMMUTABLE_STRING_32]
			-- Boogie program in lines

	routines_arguments: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32]
			-- Mapping from the target routine to its list of arguments: class.routine -> list of arguments

	result_types: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Mapping from the target routine to its return type (the value would be "" if the routine is a procedure)

	class_fields: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32]
			-- Mapping from class to its lists of fields

	fields_types: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Mapping from a class attribute to its type: class.attribute -> type

	line_index: INTEGER
			-- The current line position

	arguments_types: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Mapping from a routine argument to its type: class.routine.argument -> type

	creation_procedures: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32]
			-- Mapping from class names to used creation procedures

feature  -- Parse .bpl file to obtain context information

	get_verification_context (error_routines: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32])
			-- Obtain the context information from the .bpl file
			-- For each target class, obtain the attributes' names and their types
			-- For each target routine in each target class, obtain the return type and arguments
		local
			class_name: STRING_32
		do
			class_name := ""

			from read_next_line
			until end_of_bpl_file or bpl_lines [line_index].has_substring ("Custom") -- start from custom content
			loop
				read_next_line
			end

			get_routine_signatures(error_routines)
			get_class_fields
		end

	get_class_fields
			-- Get fields and their types
		local
			class_name, field_name, field_type, line, w: STRING_32
		do
			class_name := ""; field_name := ""; field_type := ""; line := ""; w := ""
			from
				line_index := line_index - 1
			until
				end_of_bpl_file
			loop
				line.copy (bpl_lines [line_index])
				if line.has_substring ("const") and line.has_substring ("Field") and not line.has_substring ("Ghost") then
					w.copy (line.split (' ') [2])
					class_name.copy (w.split ('.') [1])
					field_name.copy (w.split ('.') [2].split (':').first)
					w.copy (line.split (' ') [4])
					field_type.copy (w.split (';') [1])

					if not class_fields.has (class_name) then
						class_fields.extend (<<field_name>>, class_name)
					else
						class_fields [class_name].force (field_name, class_fields [class_name].count + 1)
					end

					read_next_line; read_next_line; read_next_line; read_next_line;
					line.copy (bpl_lines [line_index])

					if field_type.has_substring ("int") then
						field_type := "INTEGER_32"
					elseif field_type.has_substring ("bool") then
						field_type := "BOOLEAN"
					elseif line.has_substring ("ref") then -- reference field
						field_type.copy ("ANY")
							-- TODO: obtain the specific field of reference type
					else
						field_type := "ANY"
					end
					fields_types.extend (field_type, class_name + "." + field_name)
				end
				read_next_line
			end
			across class_fields as attr loop
				sort (class_fields [attr.key])
			end

		end

	read_next_line
			-- Move to the next line of .bpl file
		do
			line_index := line_index + 1
		end

	end_of_bpl_file: BOOLEAN
		do
			Result := line_index >= bpl_lines.count
		end

	get_creation_procedure (line: STRING_32; class_name: STRING_32)
			-- Get the signature of the creation procedure(s)
		local
			procedure_name: STRING
		do
			procedure_name := ""
			procedure_name.copy (line.split ('.').last.split ('(').first)
			if not creation_procedures.has (class_name) then
				creation_procedures.extend (<<procedure_name>>, class_name)
			else
				creation_procedures [class_name].force (procedure_name, creation_procedures [class_name].count + 1)
			end
				-- TODO: what values should be applied in creation procedure (default value?)
				-- TODO: get the arguments of the creation procedure
		end

	get_target_routine (line: STRING_32; class_name: STRING_32; routine_name: STRING_32)
			-- Get the signature of the target routine(s)
		local
			t, argument_name, argument_type, signature: STRING_32
		do
			t := ""; argument_name := ""; argument_type := ""; signature := ""
			signature.copy (line)

			if line.has_substring ("Result") then -- Obtain the result type
				if line.has_substring ("Heap") then -- Result is a reference
					t.copy (line.split (' ').last.split (')').first)
				elseif line.has_substring ("is_integer_32") then
					t := "INTEGER_32"
				end
				result_types.extend (t, class_name + "." + routine_name)
			else
				result_types.extend ("", class_name + "." + routine_name)
			end

			from
				read_next_line
			until
				end_of_bpl_file or bpl_lines [line_index].has_substring ("ensure")
			loop
				line.copy (bpl_lines [line_index])
				if line.has_substring ("info:type property for argument ") and signature.has_substring (line.split ('%/160/').last) then
					argument_name.copy (line.split ('%/160/').last)
					if line.has_substring ("Heap") then -- argument type is a reference type
						argument_type.copy (line.split (')').first.split (' ').last)
					elseif line.has_substring ("is_integer_32") then
							-- TODO: add other basic types
						argument_type.copy ("INTEGER_32")
					else
						argument_type.copy ("ANY")
							-- TODO: add support for other basic types
					end

					if not argument_name.same_string ("Current") then
						if not routines_arguments.has (class_name + "." + routine_name) then
							routines_arguments.extend (<<argument_name>>, class_name + "." + routine_name)
						else
							routines_arguments [class_name + "." + routine_name].force (argument_name, routines_arguments [class_name + "." + routine_name].count + 1)
						end
						arguments_types.extend (argument_type, class_name + "." + routine_name + "." + argument_name)
					end
				end
				read_next_line
			end
		end

	get_routine_signatures(error_routines: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32])
			-- Get the return types and arguments'types from routines' signature
		local
			line, class_name, routine_name: STRING_32
			words: LIST[STRING_32]

		do
			line := ""; class_name := ""; routine_name:=""
            error_routines.compare_objects

			from
				read_next_line
			until
				end_of_bpl_file or (line.has_substring ("const") and line.has_substring ("Field"))
			loop
				line.copy (bpl_lines [line_index])

				if line.has_substring ("procedure create.") then
					class_name.copy (line.split('(').first.split (' ')[2].split ('.')[2])
					if error_routines.has (class_name) then
					   get_creation_procedure (line, class_name)
					end

				elseif line.has_substring ("procedure") and line.has_substring (".")  then
                    words := line.split('(').first.split (' ')[2].split ('.')
                    class_name.copy (words[1])
                    routine_name.copy(words[2])

				    if error_routines.has(class_name) then
				    	 error_routines[class_name].compare_objects
				    	if error_routines[class_name].has(routine_name) then
					     get_target_routine (line, class_name, routine_name)
					    end
					end
				end
				read_next_line
			end
		end

	is_container_type (type: STRING_32): BOOLEAN
			-- Is `type' a container class?
		do
			Result := False
			if type.has_substring ("ARRAY") or type.has_substring ("SEQUENCE") or
				type.has_substring ("LIST") or type.has_substring ("BAG") or
				type.has_substring ("SET") or type.has_substring ("MAP") or
				type.has_substring ("RELATION") or type.has_substring ("TABLE") or
				type.has_substring ("INTERVAL") or type.has_substring ("TUPLE")
			then
				Result := True
			end

		end

	sort (a: ARRAY [IMMUTABLE_STRING_32])
			-- Sort a sequence in ascending order
		local
			temp: STRING_32
			i, j: INTEGER
		do
			temp := ""
			if a.count > 0 then
				from
					i := 1
				until
					i = a.count
				loop
					from
						j := i
					until
						j > a.count
					loop
						if a [i] > a [j] then
							temp.copy (a [i])
							a [i].copy (a [j])
							a [j].copy (temp)
						end
						j := j + 1
					end
					i := i + 1
				end
			end
		end

end

