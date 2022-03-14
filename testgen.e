note
	description: "TestGen application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TESTGEN

create
	generate_tests

feature {NONE} -- Initialization

	generate_tests
			-- Run application.
		local
			model_file: PLAIN_TEXT_FILE
			dir_file: PLAIN_TEXT_FILE
			model_file_string: STRING_32
			models: ARRAY [IMMUTABLE_STRING_32]
			i, end_of_model: INTEGER
			mdl, in_dir, out_dir: STRING_32
			ce: COUNTER_EXAMPLE
			flag: BOOLEAN
		do

			model_file_string := ""
			mdl := ""
			in_dir := ""
			out_dir := ""
			bpl_file_name := "autoproof.bpl"
			model_file_name := "ce.model"
			output_file_name := "test_set.e"

			create dir_file.make_open_read ("D:\Eiffel Projects\projects\proof2test\EIFGENs\proof2test-v1\W_code\dir.txt")
			dir_file.read_line
			in_dir.copy (dir_file.last_string)
			in_dir.copy (in_dir.substring (1, in_dir.count - 1))

			dir_file.read_line
			out_dir.copy (dir_file.last_string)
			out_dir.copy (out_dir.substring (1, out_dir.count - 1))

			create models.make_empty
			create CEs.make (0)
			create error_routines.make (0)

			create model_file.make_open_read (in_dir + "\ce.model")

			model_file.read_stream (1000000)
			model_file_string.copy (model_file.last_string)
			from
				i := 1
			until
				i = model_file_string.count

			loop
					-- split the model file into a set of models
				end_of_model := model_file_string.substring_index ("END_MODEL", i)
				if end_of_model /= 0 then
					mdl.copy (model_file_string.substring (i, end_of_model))
					models.force (mdl, models.count + 1)
					i := end_of_model + 1
				else
					i := model_file_string.count
				end
			end


			across models as m loop
					-- construct a ce for each model
					-- a routine might have multiple errors
				create ce.make (m.item)
				if CEs.has (ce.class_name + "." + ce.routine_name) then
					CEs [ce.class_name + "." + ce.routine_name].force (ce, CEs [ce.class_name + "." + ce.routine_name].count + 1)
				else
					CEs.extend (<<ce>>, ce.class_name + "." + ce.routine_name)
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

			create ap_context.make (in_dir, bpl_file_name, error_routines)
			create test_file.make (out_dir, output_file_name, error_routines, ap_context, CEs)
		end

feature

	bpl_file_name: STRING_32
			-- Name of the .bpl file

	model_file_name: STRING_32
			-- Name of the .model file

	output_file_name: STRING_32
			-- Name of the output test file

	ap_context: AP_CONTEXT
			-- Verification context

	CEs: HASH_TABLE [ARRAY [COUNTER_EXAMPLE], IMMUTABLE_STRING_32]
			-- Information of the counter examples: class.routine -> a list of CE

	error_routines: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32]
            -- Information of the target routines: routine -> class

	test_file: TEST_FILE
			-- Generated test cases

end
