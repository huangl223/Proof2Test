note
	description: "Root class of the application."
	author: "Li Huang"
	date: "$2022-03-22$"
	revision: "$1.0$"

class
	PROOF2TEST

inherit
	ANY
		redefine
			default_create
		end

feature {NONE}

	default_create
			-- Initialization
		local
			cmd_arguments: ARGUMENTS
		do
			create cmd_arguments
			create counterexamples.make (0)
			create error_routines.make (0)

			print ("Input boogie file: ")
			print (cmd_arguments.separate_character_option_value ('b') + "%N")
			bpl_file_name :=  (cmd_arguments.separate_character_option_value ('b'))

			print ("Input model file: ")
			print (cmd_arguments.separate_character_option_value ('m') + "%N")
			model_file_name :=  (cmd_arguments.separate_character_option_value ('m'))

			print ("Output test file: ")
			print (cmd_arguments.separate_character_option_value ('t') + "%N")
			test_file_name := safe_file_name (cmd_arguments.separate_character_option_value ('t'))

			generate_tests

		end

feature {NONE}

	generate_tests
			-- Generate tests from counterexample models.
		local
			model_file, bpl_file: PLAIN_TEXT_FILE
			model_file_content: STRING_32
			bpl_lines: ARRAY[IMMUTABLE_STRING_32]
			models: ARRAY [IMMUTABLE_STRING_32]
			i: INTEGER
		do

			model_file_content := "";
			create models.make_empty

			create model_file.make_open_read (model_file_name)
			model_file.read_stream (1000000)
			model_file_content.copy (model_file.last_string)

			models := split_models (model_file_content)
			parse_models (models)

            create bpl_file.make_open_read (bpl_file_name)
            create bpl_lines.make_empty
            bpl_file.set_utf8_encoding
            from
            until
            	bpl_file.end_of_file
            loop
            	bpl_file.read_unicode_line
            	bpl_lines.force(bpl_file.last_string_32, i)
            	i := i + 1
            end

			create ap_context.make (bpl_lines, error_routines)
			create test_file.make (test_file_name, error_routines, ap_context, counterexamples)
		end

	split_models (model_file_content: STRING_32): ARRAY [IMMUTABLE_STRING_32]
			-- Split the content of the input .model file into a list of models
		require
			model_not_empty: not model_file_content.is_empty
		local
			i, end_of_model: INTEGER
			model: STRING_32
			models: ARRAY [IMMUTABLE_STRING_32]
		do
			create models.make_empty
			from
				i := 1
				model := ""
			until
				i = model_file_content.count

			loop
				end_of_model := model_file_content.substring_index ("END_MODEL", i)
				if end_of_model /= 0 then
					model.copy (model_file_content.substring (i, end_of_model))
					models.force (model, models.count + 1)
					i := end_of_model + 1
				else
					i := model_file_content.count
				end
			end

			Result := models
		end

	parse_models (models: ARRAY [IMMUTABLE_STRING_32])
			-- Parse the model text and collect the counterexample information
		local
			ce: COUNTEREXAMPLE
			flag: BOOLEAN
		do
			across models as m loop
				create ce.make (m.item)
				if counterexamples.has (ce.class_name + "." + ce.routine_name) then
					counterexamples [ce.class_name + "." + ce.routine_name].force (ce, counterexamples [ce.class_name + "." + ce.routine_name].count + 1)
				else
					counterexamples.extend (<<ce>>, ce.class_name + "." + ce.routine_name)
				end

				if not error_routines.has (ce.class_name) then
					error_routines.extend (<<ce.routine_name>>, ce.class_name)
				else
					flag := False
					across error_routines [ce.class_name] as r loop
						flag := r.item.same_string (ce.routine_name)
					end
					if not flag then
						error_routines [ce.class_name].force (ce.routine_name, error_routines [ce.class_name].count + 1)
					end
				end
			end
		end

	safe_file_name (a_file_name: STRING_32): STRING_32
			-- Safe version of `a_file_name' in case of space.
		do
			if a_file_name.has (' ') then
				Result := "%"" + a_file_name + "%""
			else
				Result := a_file_name
			end
		end

feature

	bpl_file_name: STRING_32
			-- Name of the .bpl file

	model_file_name: STRING_32
			-- Name of the .model file

	test_file_name: STRING_32
			-- Name of the output test file

	ap_context: PROOF_CONTEXT
			-- Verification context

	counterexamples: HASH_TABLE [ARRAY [COUNTEREXAMPLE], IMMUTABLE_STRING_32]
			-- Mapping from a target routine to a list of counterexamples

	error_routines: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32]
			-- Information of the target routines: routine -> class

	test_file: TEST_FILE
			-- Generated test cases



end
