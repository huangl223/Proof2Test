note
	description: "Summary description for {TEST_FILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_FILE
create
	make

feature

	make (dir: STRING_32; output_file_name: STRING_32; ap_error_routines: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32]; ap_context: AP_CONTEXT; CEs: HASH_TABLE [ARRAY [COUNTER_EXAMPLE], IMMUTABLE_STRING_32])
		local
			class_name: STRING_32
			routine_name: STRING_32
		do

			create output_file.make_create_read_write (dir + "/" + output_file_name)
			create alias_groups.make (0)
			create counter_examples.make (0)
			create missing_values.make_empty
			create error_routines.make (0)

			error_routines := ap_error_routines
			proof_context := ap_context
			counter_examples := CEs

			output_file.put_string (header)

			class_name := ""
			routine_name := ""

			across error_routines as res loop
				class_name.copy (res.key)
				output_file.put_string (test_cases_of_class (class_name))
			end
		end

feature

	output_file: PLAIN_TEXT_FILE
			-- Output file that writes the test cases

	proof_context: AP_CONTEXT
			-- Verification project context

	counter_examples: HASH_TABLE [ARRAY [COUNTER_EXAMPLE], IMMUTABLE_STRING_32]
			-- Mapping from class.routine to a set of counter example model

	alias_groups: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32]
			-- Mapping from an abstract value (object) to a list of references

	missing_values: ARRAY [IMMUTABLE_STRING_32]
			-- A set of variables whose values are missing

	error_routines: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32]

feature

	is_consistent (ce: COUNTER_EXAMPLE): BOOLEAN
		do
				-- TODO: check the test data is consistent with class invariant

		end

	header: STRING_32
			-- Header of the file
		local
			s: STRING_32
		do
			s := ""
			Result := ""
			s := s + "class NEW_TEST_SET%Ninherit%NEQA_TEST_SET%N%N"
			s := s + "feature -- Test routines %N%N"

			Result.copy (s)
		end

	object_creation (class_name: STRING_32; routine_name: STRING_32): STRING_32
			-- Declaration of all variables (i.e., target object, internal object, arguments, result object) for a class
		local
			s1, s2: STRING_32
			result_type: STRING_32
			argument_name: STRING_32
			argument_type: STRING_32
		do
			s1 := ""
			s2 := ""
			result_type := ""
			argument_name := ""
			argument_type := ""

			s1 := "current_object: " + class_name + "%N"
			if proof_context.creation_procedures.has (class_name) then
				s2 := s2 + "create current_object." + proof_context.creation_procedures [class_name].at (1) + "%N"
			else
				s2 := s2 + "create current_object." + "default_create %N"
			end

				-- for target and internal object
				-- declaration of arguments for each routine
			if attached proof_context.arguments_of_routine [class_name + "." + routine_name] as args then
				across args as arg loop
					argument_name.copy (arg.item)
					argument_type.copy (proof_context.type_of_arguments [class_name + "." + routine_name + "." + argument_name])
					if is_container_type (argument_type) then
						argument_type.copy (convert_to_base_container (argument_type))
					end
					s1 := s1 + argument_name + ": " + argument_type + "%N"
					if not is_basic_type (argument_type) then
						if proof_context.creation_procedures.has (argument_type) then
							s2 := s2 + "create " + argument_name + "." + proof_context.creation_procedures [argument_type].at (1) + "%N"
						elseif argument_type.has_substring ("SIMPLE_ARRAY") then
							s2 := s2 + "create " + argument_name + ".make_empty%N"
						elseif argument_type.has_substring ("V_ARRAY") then
							s2 := s2 + "create " + argument_name + ".make(1, 0)%N"
						else
							s2 := s2 + "create " + argument_name + ".default_create %N"
						end
					end

					result_type.copy (proof_context.result_types [class_name + "." + routine_name])
					if is_container_type (result_type) then
						result_type.copy (convert_to_base_container (result_type))
					end
				end

				if not result_type.same_string ("") then -- TODO: result type can be basic type
						-- the routine is a function
					s1 := s1 + routine_name + "_result:" + result_type + "%N"
					if not is_basic_type (result_type) then
						s2 := s2 + "create " + routine_name + "_result.default_create %N" -- TODO: get the creation procedure of each class
					end
				end
			end
			Result := "local %N" + s1 + "do  %N" + s2
		end

	test_cases_of_class (class_name: STRING_32): STRING_32
	    -- Generate test cases for a class
		local
			s, ce_str, test_case_str: STRING_32
			routine_name: STRING_32
			argument_name: STRING_32
			argument_type: STRING_32
			ce: COUNTER_EXAMPLE
			i: INTEGER
		do
			routine_name := ""
			argument_name := ""
			argument_type := ""
			s := ""

			Result := ""
			if error_routines.has (class_name) then
				across error_routines [class_name] as r loop
					routine_name.copy (r.item)
					i := 1
					across counter_examples [class_name + "." + routine_name] as c loop
						alias_groups.make (0)
						ce := c.item
						s := s + "test_" + class_name + "_" + routine_name + "_" + i.out + "%N"
							-- s := s + header TODO: add header for each test

						s := s + object_creation (class_name, routine_name)
						s := s + initialize_object ("Current", class_name, ce)
							-- initialize the target object
						if proof_context.arguments_of_routine.has (class_name + "." + routine_name) then
							across proof_context.arguments_of_routine [class_name + "." + routine_name] as arg loop
									-- initialize arguments of each routine
								argument_name.copy (arg.item)
								argument_type.copy (proof_context.type_of_arguments [class_name + "." + routine_name + "." + argument_name])
								s := s + initialize_object (argument_name, argument_type, ce)
							end
						end

						s := s + routine_call (class_name, routine_name, proof_context.result_types [class_name + "." + routine_name])
						s := s + "%Nend%N%N"
						i := i + 1
					end
				end
			end
			s := s + "%Nend%N%N"
			Result.copy (s)

		end

	initialize_object (object_name: STRING_32; class_name: STRING_32; ce: COUNTER_EXAMPLE): STRING_32
	    -- Initialize an object
	    local
			attribute_name: STRING_32
			attribute_type: STRING_32
			attribute_id: STRING_32
			attribute_value: STRING_32
			i, k: INTEGER
			s: STRING_32
			class_name_: STRING_32

		do
			attribute_name := ""
			attribute_type := ""
			attribute_id := ""
			attribute_value := ""
			class_name_ := ""
			class_name_.copy (class_name)
			s := ""
			Result := ""

			if not is_basic_type (class_name) then
				if is_alias (object_name, ce) and not object_name.same_string ("Current") then
					if not alias_groups [ce.initial_values [object_name]] [1].same_string ("Current") then
						s := s + object_name + " := " + alias_groups [ce.initial_values [object_name]] [1] + " %N"
					else
						s := s + object_name + " := current_object %N"
					end
				elseif is_container_type (class_name) then
						--initialize_container(object_name: STRING; type: STRING; value: STRING; ce: COUNTER_EXAMPLE): STRING
					s := s + initialize_container (object_name, class_name, ce.initial_values [object_name], ce)
				elseif proof_context.attributes_of_class.has (class_name) then
					from
						i := 1
					until
						i > proof_context.attributes_of_class [class_name].count
					loop -- for each attribute
						attribute_name.copy (proof_context.attributes_of_class [class_name] [i])
						attribute_type.copy (proof_context.type_of_attributes [class_name + "." + attribute_name])
						attribute_id.copy (ce.constants [class_name + "." + attribute_name])
						print ("attribute_id: " + class_name + "." + attribute_name + "->" + attribute_id + "%N")

						if is_basic_type (attribute_type) then
							if ce.heap_function.has (ce.initial_values [object_name] + ", " + attribute_id) then
								attribute_value := ce.heap_function [ce.initial_values [object_name] + ", " + attribute_id]
								print ("attribute_value: " + class_name + "." + attribute_name + "->" + attribute_value + "%N")
							else -- the value of the attribute is missing
								missing_values.force (object_name + "." + attribute_name, missing_values.count)
							end
							attribute_type.to_lower
							if not object_name.same_string ("Current") then
								s := s + "{INTERNAL}.set_" + attribute_type + "_field(" + i.out + ", " + object_name + ", " + attribute_value + ")%N"
								s := s + ("  -- " + object_name + "." + attribute_name + " -> " + attribute_value + "%N")
							else
								s := s + "{INTERNAL}.set_" + attribute_type + "_field(" + i.out + ",  current_object" + ", " + attribute_value + ")%N"
								s := s + ("  -- current_object." + attribute_name + " = " + attribute_value + "%N")
							end

						else
							-- TODO: when the attribute is also a reference type
							s := s + initialize_object (attribute_name, attribute_type, ce)
						end
						i := i + 1
					end
				else -- Reference type that has no attributes
					s := s
				end

			else
				s := s + object_name + ":= " + ce.initial_values [object_name] + "%N"

			end
			Result.copy (s)
		end

	routine_call (class_name: STRING_32; routine_name: STRING_32; result_type: STRING_32): STRING_32
			-- Invoke the call with initialized objects
		local
			s: STRING_32
			i: INTEGER
			argument_name: STRING_32
		do
			s := ""
			Result := ""
			argument_name := ""
			if not result_type.same_string ("") then
					-- the routine is a function
				s := s + routine_name + "_result := "
			end
			s := s + "current_object." + routine_name

			i := 1
			if proof_context.arguments_of_routine.has (class_name + "." + routine_name) then
				s := s + "("
				across proof_context.arguments_of_routine [class_name + "." + routine_name] as arg loop
					argument_name.copy (arg.item)
					s := s + argument_name
					if i < proof_context.arguments_of_routine [class_name + "." + routine_name].count then
						s := s + ", "
					end
					i := i + 1
				end
				s := s + ")"
			end

			Result.copy (s)
		end

	is_basic_type (type: STRING_32): BOOLEAN
			-- Is the given type a basic type?
		do
			if type.same_string ("INTEGER") or type.same_string ("INTEGER_32") or
				type.same_string ("NATURAL") or type.same_string ("BOOLEAN") or type.same_string ("CHARACTER") or
				type.same_string ("STRING") or type.same_string ("REAL") then
				Result := True
			else
				Result := False
			end
		end

	is_alias (object_name: STRING_32; ce: COUNTER_EXAMPLE): BOOLEAN
	    -- Is the given object an alias with one of the instantiated objects?
		local
			object_value: IMMUTABLE_STRING_32
		do
			object_value := ""
			object_value.copy (ce.initial_values [object_name])
			Result := False

			if alias_groups.has (object_value) then
				Result := True
				alias_groups [object_value].force (object_name, alias_groups [object_value].count + 1)
			else
				alias_groups.extend (<<object_name>>, object_value)
			end

		end

	is_container_type (type: STRING_32): BOOLEAN
	    -- Is the given type a container type?
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

	initialize_container (object_name: STRING_32; type: STRING_32; value: STRING_32; ce: COUNTER_EXAMPLE): STRING_32
	    -- Instantiate an object of container type
		local
			k: INTEGER
			s: STRING_32
			seq_value: STRING_32
		do
			s := ""
			Result := ""
			seq_value := ""
			if type.has_substring ("V_ARRAY") or type.has_substring ("SIMPLE_ARRAY")then
				seq_value.copy (ce.heap_function [ce.initial_values [object_name] + ", " + ce.constants [type + ".sequence"]])
				if ce.seq_lengths.has (seq_value) and ce.seq_item.count > 0 then
					from
						k := 1
					until
						k > ce.seq_lengths [seq_value].to_integer_32
					loop
						if ce.seq_item.has (seq_value + ", " + k.out) then
							s := s + object_name + ".force(" + ce.seq_item [seq_value + ", " + k.out] + ", " + k.out + ")%N"
						else
							-- s := s + object_name + ".force(" + ce.seq_item ["else"] + ", " + k.out + ")%N"
							 s := s + object_name + ".force(" + "0" + ", " + k.out + ")%N"
						end
						k := k + 1
					end
				else
					s := s + "No sequence found in the counterexample model. %N"
				end

				s := s + "%N"
			end

			Result.copy (s)
		end

	convert_to_base_container (type: STRING_32): STRING_32
	    -- Convert the name of container type
		local
			s: STRING_32
			element_type: STRING_32
			tuple_field_types: LIST [STRING_32]
			i: INTEGER
		do
			s := ""
			Result := ""
			element_type := ""
			if type.has_substring ("V_ARRAY") then
				element_type.copy (type.split ('^') [2])
				s := s + "V_ARRAY" + "[" + element_type + "]"
			elseif type.has_substring ("SIMPLE_ARRAY") then
				element_type.copy (type.split ('^') [2])
				s := s + "SIMPLE_ARRAY" + "[" + element_type + "]"
			elseif type.has_substring ("LIST") then
				element_type.copy (type.split ('^') [2])
				s := s + "LIST" + "[" + element_type + "]"
			elseif type.has_substring ("TUPLE") then
				tuple_field_types := type.split ('#')
				tuple_field_types [1].copy (tuple_field_types [1].split ('^').last)
				s := s + "TUPLE" + "["
				from
					i := 1
				until
					i = tuple_field_types.count
				loop
					s := s + tuple_field_types [i] + ","
					i := i + 1
				end

				s := s + tuple_field_types [i].split ('^').first + "]"
			end

			Result.copy (s)
		end

end

