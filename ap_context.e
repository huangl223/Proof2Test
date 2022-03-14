note
	description: "Extract context information from Boogie program (.bpl file)."
	author: "Li Huang"
	date: "$2022-03-07$"
	revision: "$Revision 1.0$"

class
	AP_CONTEXT

create
	make

feature
	make (directory: STRING_32; bpl_file_name: STRING_32; error_routines: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32])
		local
			class_name: STRING_32
			routine_name: STRING_32
		do
			create arguments_of_routine.make (0)
			create result_types.make (0)
			create attributes_of_class.make (0)
			create type_of_attributes.make (0)
			create type_of_arguments.make (0)
			create creation_procedures.make (0)

			class_name := ""
			routine_name := ""

			across error_routines as err loop
					-- get attributes and their types of each class
				class_name.copy (err.key)
				get_class_attributes (directory, bpl_file_name)

				across error_routines [err.key] as r loop
						-- get return_type and arguments of each routine
					routine_name.copy (r.item)
					get_routine_signature (directory, bpl_file_name, class_name, routine_name)
				end

			end

		end

feature -- attributes

	arguments_of_routine: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32]
			-- Mapping from class.routine to a list of arguments

	result_types: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Mapping from class.routine to the return type of the routine, the value would be "" if the routine is a procedure

	attributes_of_class: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32]
			-- Mapping from class to its attributes

	type_of_attributes: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Mapping from class.attribute to its type

	type_of_arguments: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Mapping from class.routine.arguments to its type

	creation_procedures: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32]
			-- Mapping from class names to used creation procedures

feature

	get_class_attributes (directory: STRING; bpl_file_name: STRING)
			-- Get the list of attributes of class and their type by parsing the .bpl file
		local
			class_name: STRING_32
			attribute_name: STRING_32
			attribute_type: STRING_32
			line: STRING_32
			w: STRING_32
			bpl_file: PLAIN_TEXT_FILE
		do
			class_name := ""
			attribute_name := ""
			attribute_type := ""
			line := ""
			w := ""

			create bpl_file.make_open_read (directory + "\" + bpl_file_name)
			bpl_file.set_utf8_encoding

			from
				bpl_file.read_unicode_line
			until
				bpl_file.end_of_file
			loop
				line.copy (bpl_file.last_string_32)

				if line.has_substring ("const") and line.has_substring ("Field") and not line.has_substring ("Ghost") then
						-- attribute name
					w.copy (line.split (' ') [2])
					class_name.copy (w.split ('.') [1])
					attribute_name.copy (w.split ('.') [2].split (':').first)
					w.copy (line.split (' ') [4])
					attribute_type.copy (w.split (';') [1])

					if not attributes_of_class.has (class_name) then
						attributes_of_class.extend (<<attribute_name>>, class_name)
					else
						attributes_of_class [class_name].force (attribute_name, attributes_of_class [class_name].count + 1)
					end
						-- attribute type
					bpl_file.read_unicode_line; bpl_file.read_unicode_line; bpl_file.read_unicode_line; bpl_file.read_unicode_line
					line.copy (bpl_file.last_string_32)

					if attribute_type.has_substring ("int") then
						attribute_type := "INTEGER_32"
					elseif attribute_type.has_substring ("bool") then
						attribute_type := "BOOLEAN"
					elseif line.has_substring ("_exact") then -- reference type
						attribute_type.copy (line.split (' ').last.split (')').first)
					else
						attribute_type := "ANY"
					end
					type_of_attributes.extend (attribute_type, class_name + "." + attribute_name)
				end
				bpl_file.read_unicode_line
			end
			across attributes_of_class as attr loop
				sort (attributes_of_class [attr.key])
			end

			bpl_file.close
		end

	get_routine_signature (directory: STRING; bpl_file_name: STRING; class_name: STRING; routine_name: STRING)
			-- Get the return type and arguments from routine's signature
		local
			line: STRING_32
			t: STRING_32
			argument_name: STRING_32
			argument_type: STRING_32
			bpl_file: PLAIN_TEXT_FILE
			pro_flag: BOOLEAN
			signature: STRING_32
			procedure_name: STRING_32
			argument_count: INTEGER

		do
			line := ""
			t := ""
			argument_name := ""
			argument_type := ""
			pro_flag := False
			signature := ""
			procedure_name := ""

			create bpl_file.make_open_read (directory + "\" + bpl_file_name)
			bpl_file.set_utf8_encoding

			from
				bpl_file.read_unicode_line
			until
				bpl_file.end_of_file
			loop
				line.copy (bpl_file.last_string_32)

				if line.has_substring ("procedure create." + class_name) then
					procedure_name.copy (line.split ('.').last.split ('(').first)
					if not creation_procedures.has (class_name) then
						creation_procedures.extend (<<procedure_name>>, class_name)
					else
						creation_procedures [class_name].force (procedure_name, creation_procedures [class_name].count + 1)
					end
						-- TODO: what values should be applied in creation procedure (default value)
						-- if the argument is a reference type, initialize the reference first
				end

				if line.has_substring ("procedure " + class_name + "." + routine_name) then
					signature.copy (line)
					if line.has_substring ("Result") then
							-- the context routine is a function, obtain the result type
						if line.has_substring ("Heap") then
								-- Result is a reference
							t.copy (line.split (' ').last.split (')').first)
								--if is_container_type(t) then
								--   t.copy (convert_to_base_container(t))
								--end
						elseif line.has_substring ("is_integer_32") then
							t := "INTEGER_32"
						end

						result_types.extend (t, class_name + "." + routine_name)
					else
						result_types.extend ("", class_name + "." + routine_name)
					end

					from
						bpl_file.read_unicode_line
					until
						bpl_file.last_string_32.has_substring ("ensure") or bpl_file.end_of_file
					loop
						line.copy (bpl_file.last_string_32)
						if line.has_substring ("info:type property for argument ") and signature.has_substring (line.split ('%/160/').last) then
							argument_name.copy (line.split ('%/160/').last)
							if line.has_substring ("Heap") then
									-- argument type is a reference type
								argument_type.copy (line.split (')').first.split (' ').last)
									--if is_container_type(argument_type) then
									--    argument_type.copy (convert_to_base_container(argument_type))
									-- end
							elseif line.has_substring ("is_integer_32") then
									-- argument type is a basic type -- TODO: add other basic types
								argument_type.copy ("INTEGER_32")
							else
								argument_type.copy ("ANY") -- TODO: add support for other basic types
							end

							if not argument_name.same_string ("Current") then -- "Current" is not an argument
								if not arguments_of_routine.has (class_name + "." + routine_name) then
									arguments_of_routine.extend (<<argument_name>>, class_name + "." + routine_name)
								else
									arguments_of_routine [class_name + "." + routine_name].force (argument_name, arguments_of_routine [class_name + "." + routine_name].count + 1)
								end
								type_of_arguments.extend (argument_type, class_name + "." + routine_name + "." + argument_name)
									-- print ("argument -> " + argument_name + ": " + argument_type + "%N")
							end
						end
						bpl_file.read_unicode_line
					end
				end
				bpl_file.read_unicode_line
			end
			bpl_file.close
		end

	is_container_type (type: STRING_32): BOOLEAN
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

