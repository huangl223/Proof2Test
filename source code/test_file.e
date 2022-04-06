note
	description: "This class generates tests and writes them in the output file."
	author: "Li Huang"
	date: "$2022-03-22$"
	revision: "$1.0$"

class
	TEST_FILE

create
	make

feature -- Initialize

	make (test_file_name: STRING_32; ap_error_routines: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32]; a_proof_context: PROOF_CONTEXT; a_counterexamples: HASH_TABLE [ARRAY [COUNTEREXAMPLE], IMMUTABLE_STRING_32])

		local
			class_name: STRING_32
		do
			class_name := ""
			create alias_groups.make (0)
			create initial_values.make (0)
			create missing_values.make_empty
			create sequence_items.make (0)
			create sequence_lengths.make (0)

			error_routines := ap_error_routines
			proof_context := a_proof_context
			counterexamples := a_counterexamples

			create test_file.make_create_read_write (test_file_name)
			generate_test_file
		end

feature -- Files and data

	test_file: PLAIN_TEXT_FILE
			-- Output .e file that storeds all test cases

	proof_context: PROOF_CONTEXT
			-- Verification project context

	counterexamples: HASH_TABLE [ARRAY [COUNTEREXAMPLE], IMMUTABLE_STRING_32]
			-- Mapping from class.routine to a set of counterexamples

	alias_groups: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32]
			-- Mapping from an abstract value (object) to a list of references

	initial_values: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Mapping from objects or object fields to the corresponding value

	error_routines: HASH_TABLE [ARRAY [IMMUTABLE_STRING_32], IMMUTABLE_STRING_32]
			-- Mapping from a target class  to its list of target routines

	missing_values: ARRAY [IMMUTABLE_STRING_32]
			-- A set of variables whose values are missing

	sequence_items: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Sequences' elements

	sequence_lengths: HASH_TABLE [IMMUTABLE_STRING_32, IMMUTABLE_STRING_32]
			-- Sequences's lengths

feature -- Test generation

	generate_test_file
			-- Write the test cases to the output file
		local
			class_name, routine_name, t: STRING_32
			i: INTEGER
		do
			class_name := ""; t := ""; routine_name := ""
			test_file.put_string (header)

			across error_routines as res loop
				class_name.copy (res.key)
				if error_routines.has (class_name) then
					across error_routines [class_name] as r loop
						i := 1
						routine_name.copy (r.item)
						across counterexamples [class_name + "." + routine_name] as m loop
							t := t + generate_test (class_name, routine_name, m.item, i)
							i := i + 1
						end
					end
				end
				test_file.put_string (t)
			end
			test_file.put_string ("end%N")
		end

	header: STRING_32
			-- Header of the test file
		do
			Result := "class NEW_TEST_SET%N%Ninherit%N%TEQA_TEST_SET%N%N" + "feature -- Tests from failed proofs %N%N"
		end

	compute_alias
			-- Store the aliases into the same group
		local
			name, value: STRING_32
		do
			alias_groups.make (0)

			across initial_values as var loop
				name := var.key
				value := initial_values [var.key]

				if is_abstract_value (value) then
					if alias_groups.has (value) then
						alias_groups [value].compare_objects
						if (not alias_groups [value].has (name)) then
							alias_groups [value].force (name, alias_groups [value].count + 1)
						end
					else
						alias_groups.extend (<<name>>, value)
					end
				end
			end

		end

	generate_test (class_name: STRING_32; routine_name: STRING_32; m: COUNTEREXAMPLE; i: INTEGER): STRING_32
			-- Generate the ith test case for the target routine based on the counterexample model m
		local
			t, td, tc, ti: STRING_32
			argument_name, argument_type, result_type: STRING_32
		do
			argument_name := ""; argument_type := ""; Result := ""; result_type := ""

			initial_values.make (0)
			get_initial_state (class_name, routine_name, m)

			compute_alias
			sequence_items := m.seq_item
			sequence_lengths := m.seq_lengths

			t := "%Ttest_" + class_name + "_" + routine_name + "_" + i.out + "%N"
				-- TODO: add header comements for each test routine

			td := declare_object ("current_object", class_name)
			tc := create_object ("current_object", class_name, m)
			ti := instantiate_object ("current_object", class_name)

			if proof_context.routines_arguments.has (class_name + "." + routine_name) then

				across proof_context.routines_arguments [class_name + "." + routine_name] as arg loop
					argument_name.copy (arg.item)
					argument_type.copy (proof_context.arguments_types [class_name + "." + routine_name + "." + argument_name])

					td := td + declare_object (argument_name, argument_type)
					tc := tc + create_object (argument_name, argument_type, m)
					ti := ti + instantiate_object (argument_name, argument_type)
				end

			end
			result_type.copy (proof_context.result_types [class_name + "." + routine_name])

			if is_container_type (result_type) then
				result_type.copy (safe_type (result_type))
			end

			if not result_type.same_string ("") then
				td := td + declare_object (routine_name + "_result", result_type)
				t := t + "%T%Tlocal %N" + td + "%T%Tdo%N" + tc + ti
				t := t + "%T%T%T" + routine_name + "_result := " + routine_call (class_name, routine_name) + "%N%T%Tend%N%N"
			else
				t := t + "%T%Tlocal %N" + td + "%T%Tdo%N" + tc + ti
				t := t + "%T%T%T" + routine_call (class_name, routine_name) + "%N%T%Tend%N%N"
			end

			Result.copy (t)
		end

	declare_object (object_name: STRING_32; object_type: STRING_32): STRING_32
			-- Declaration of all object references
		do
			Result := "%T%T%T" + object_name + ": " + safe_type (object_type) + "%N"
		end

	creation_routine_call (object_type: STRING_32): STRING_32
			-- The first creation procedure of `type'
		do
			Result := ""
			if not proof_context.creation_procedures [object_type].at (1).same_string ("default_create") then
				Result.copy ("." + proof_context.creation_procedures [object_type].at (1))
			end
		end

	create_object (object_name: STRING_32; class_name: STRING_32; m: COUNTEREXAMPLE): STRING_32
			-- Creation of all object references
		local
			object_type: STRING_32
		do
			object_type := ""; Result := ""
			object_type.copy (safe_type (class_name))

			if not is_basic_type (object_type) and not is_aliased_with_existed_object (object_name) then

				if proof_context.creation_procedures.has (object_type) then
					Result := "%T%T%Tcreate " + object_name + creation_routine_call (object_type) + "%N"
				elseif object_type.has_substring ("SIMPLE_ARRAY") then
					Result := "%T%T%Tcreate " + object_name + ".make_empty%N"
				elseif object_type.has_substring ("V_ARRAY") then
					Result := "%T%T%Tcreate " + object_name + ".make(1, 0)%N"
						-- TODO: create clause for other container types
				else
					Result := "%T%T%Tcreate " + object_name + "%N"
				end

			end
		end

	instantiate_object (object_name: STRING_32; class_name: STRING_32): STRING_32
			-- Instantiate an object
		local
			t, class_name_: STRING_32
		do
			t := ""; Result := ""; class_name_ := ""
			class_name_.copy (safe_type (class_name))

			if initial_values.has (object_name) then -- value obtained in the counterexample model
				if is_basic_type (class_name) then
					t := t + assignment (object_name, initial_values [object_name])
				else
					t := t + instantiate_object_reference (object_name, class_name)

				end
			end

			Result.copy (t)
		end

	assignment (object_name: STRING_32; object_value: STRING_32): STRING_32
			-- Assignment clause for assigning the given value
		do
			Result := "%T%T%T" + object_name + " := " + object_value + "%N"
		end

	instantiate_object_reference (object_name: STRING_32; object_type: STRING_32): STRING_32
			-- Initialize an object reference 'object_name' based on the given counterexample `m'
		local
			t, field_name, field_type, field_value: STRING_32
			i: INTEGER
		do
			t := ""; field_name := ""; field_type := ""; field_value := ""; Result := ""

			if is_aliased_with_existed_object (object_name) then
				t := t + assignment (object_name, alias_groups [initial_values [object_name]] [1])
			elseif is_container_type (object_type) then
				t := t + instantiate_container_object (object_name, object_type)
			else

				if proof_context.class_fields.has (object_type) then
					across proof_context.class_fields [object_type] as a loop
					end

					from
						i := 1
					until
						i > proof_context.class_fields [object_type].count
					loop
						field_name.copy (proof_context.class_fields [object_type] [i])
						field_type.copy (proof_context.fields_types [object_type + "." + field_name])
						field_value.copy (initial_values [object_name + "." + field_name])

						if is_basic_type (field_type) then
							t := t + instantiate_basic_field (object_name, field_name, field_type, field_value, i)
						else
							t := t + instantiate_object_reference (object_name + "." + field_name, field_type)
						end

						i := i + 1
					end

				end

			end

			Result.copy (t)
		end

	instantiate_basic_field (object_name: STRING_32; field_name: STRING_32; field_type: STRING_32; field_value: STRING_32; i: INTEGER): STRING_32
			-- Initialize an object field of basic type
		local
			name, value: STRING_32
		do
			name := object_name + "." + field_name

			if initial_values.has (name) then
				value := initial_values [name]
			else
				missing_values.force (object_name + "." + field_name, missing_values.count)
					-- TODO: the counterexample is partial
			end

			field_type.to_lower

			Result := "%T%T%T{INTERNAL}.set_" + field_type + "_field (" + i.out + ", " + object_name + ", " + value + ")%N"
				+ ("%T%T%T%T--" + object_name + "." + field_name + " = " + value + "%N")

		end

	routine_call (class_name: STRING_32; routine_name: STRING_32): STRING_32
			-- Invoke the call with initialized objects
		local
			t: STRING_32
			i: INTEGER
		do
			t := ""; Result := ""
			t := t + "current_object." + routine_name

			i := 1
			if proof_context.routines_arguments.has (class_name + "." + routine_name) then
				t := t + " ("
				across proof_context.routines_arguments [class_name + "." + routine_name] as arg loop
					t := t + arg.item

					if i < proof_context.routines_arguments [class_name + "." + routine_name].count then
						t := t + ", "
					end

					i := i + 1
				end
				t := t + ")"
			end
			Result.copy (t)
		end

	force_item (object_name: STRING_32; item_value: STRING_32; i: INTEGER): STRING_32
			-- Use force procedure to add elements to the container
		do
			Result := "%T%T%T" + object_name + ".force(" + item_value + ", " + i.out + ")%N"
		end

	instantiate_container_object (object_name: STRING_32; type: STRING_32): STRING_32
			-- Instantiate an object of container type based on the given counterexample model `m'
		local
			t, value, item_value: STRING_32
			i: INTEGER
		do
			t := ""; Result := ""; item_value := "0"

			value := initial_values [object_name + ".sequence"]

			if type.has_substring ("V_ARRAY") or type.has_substring ("SIMPLE_ARRAY") then
					-- TODO: add support for other container type

				if sequence_lengths.has (value) and sequence_items.count > 0 then

					from
						i := 1
					until
						i > sequence_lengths [value].to_integer_32
					loop

						if sequence_items.has (value + ", " + i.out) then
							item_value := sequence_items [value + ", " + i.out]
						end

						t := t + force_item (object_name, item_value, i)
						i := i + 1
					end
				else
					t := t + " -- No sequence for array " + object_name + "found in the model. %N"
				end

				t := t + "%N"
			end

			Result.copy (t)
		end

	safe_type (type: STRING_32): STRING_32
			-- Convert the name of container type
		local
			t, item_type: STRING_32
			tuple_field_types: LIST [STRING_32]
			i: INTEGER
		do
			t := ""; Result := ""; item_type := ""
			if type.has_substring ("^") then
				if type.has_substring ("V_ARRAY") then
					item_type.copy (type.split ('^') [2])
					t := t + "V_ARRAY" + "[" + item_type + "]"
				elseif type.has_substring ("SIMPLE_ARRAY") then
					item_type.copy (type.split ('^') [2])
					t := t + "SIMPLE_ARRAY" + "[" + item_type + "]"
				elseif type.has_substring ("LIST") then
					item_type.copy (type.split ('^') [2])
					t := t + "LIST" + "[" + item_type + "]"
				elseif type.has_substring ("TUPLE") then
					tuple_field_types := type.split ('#')
					tuple_field_types [1].copy (tuple_field_types [1].split ('^').last)
					t := t + "TUPLE" + "["

					from
						i := 1
					until
						i = tuple_field_types.count
					loop
						t := t + tuple_field_types [i] + ","
						i := i + 1
					end

					t := t + tuple_field_types [i].split ('^').first + "]"
				end
			else
				t := type
			end
			Result.copy (t)
		end

feature -- Get initial values

	get_object_value (object_name: STRING_32; m: COUNTEREXAMPLE): STRING_32
			-- Retrieve the value of `var' in the counterexample model `m'
		do
			Result := m.constants_values [object_name]
		end

	get_object_fields (object_name: STRING_32; object_type: STRING_32; m: COUNTEREXAMPLE)
			-- Obtain all fields of an object
		local
			i: INTEGER
			field_name, field_type, field_value: STRING_32
		do
			field_name := ""; field_type := ""; field_value := ""
			from
				i := 1
			until
				i > proof_context.class_fields [object_type].count
			loop
				field_name.copy (proof_context.class_fields [object_type] [i])
				field_type.copy (proof_context.fields_types [object_type + "." + field_name])

				if m.class_field_relations.has (object_type + "." + field_name)
					and m.heap_function.has (initial_values [object_name] + ", " + m.class_field_relations [object_type + "." + field_name]) then
					field_value.copy (m.heap_function [initial_values [object_name] + ", " + m.class_field_relations [object_type + "." + field_name]])

				end

				initial_values [object_name + "." + field_name] := ""
				initial_values [object_name + "." + field_name].copy (field_value)

				if not is_basic_type (field_type) and proof_context.class_fields.has (field_type) then

					get_object_fields (object_name + "." + field_name, field_type, m)
				end

				i := i + 1
			end
		end

	get_object_initial_state (object_name: STRING_32; object_type: STRING_32; m: COUNTEREXAMPLE)
			-- Obtain the initial state of an object
		local
			object_value: STRING_32
		do
			object_value := get_object_value (object_name, m)
			initial_values [object_name] := ""
			initial_values [object_name].copy (object_value)

			if proof_context.class_fields.has (object_type) then
				get_object_fields (object_name, object_type, m)
			end

		end

	get_initial_state (class_name: STRING_32; routine_name: STRING_32; m: COUNTEREXAMPLE)
			-- Obtain the object fields based on the heap function
		local
			argument_name, argument_type: STRING_32
		do
			argument_name := ""; argument_type := ""

			get_object_initial_state ("current_object", class_name, m)

			if proof_context.routines_arguments.has (class_name + "." + routine_name) then

				across proof_context.routines_arguments [class_name + "." + routine_name] as arg loop
					argument_name.copy (arg.item)
					argument_type.copy (proof_context.arguments_types [class_name + "." + routine_name + "." + argument_name])
					get_object_initial_state (argument_name, argument_type, m)
				end
			end
		end

	get_field_index
			-- Obtain the index of an object field
		local
			o: REFLECTED_REFERENCE_OBJECT
		do
				--TODO: arrange the order of object fields
				-- create o.make (object_to_modify)
				-- across 1 |..| o.field_count as i loop
				-- `field_to_lookup` is in UTF-8 (ASCII is fine as well).
				--    if o.field_name (i).same_string (field_to_lookup) then
				--	    o.set_integer_field (i, o, new_field_value)
				--    end
				-- end
		end

feature -- Properties checking

	is_aliased_with_existed_object (object_name: STRING_32): BOOLEAN
			-- Is the given object an alias with one of the instantiated objects?
		local
			object_value: STRING_32
		do
			object_value := ""
			object_value.copy (initial_values [object_name])

			if alias_groups.has (object_value) and not alias_groups [object_value] [1].same_string (object_name) then
				Result := True
			else
				Result := False
			end
		end

	is_container_type (type: STRING_32): BOOLEAN
			-- Is the given type a container type?
		do
			Result := False
			if type.has_substring ("V_ARRAY") or type.has_substring ("SIMPLE_ARRAY") or type.has_substring ("SEQUENCE") or
				type.same_string ("LIST") or type.same_string ("BAG") or
				type.same_string ("SET") or type.same_string ("MAP") or
				type.same_string ("RELATION") or type.same_string ("TABLE") or
				type.same_string ("INTERVAL") or type.same_string ("TUPLE")
			then
				Result := True
			end
		end

	is_consistent (ce: COUNTEREXAMPLE): BOOLEAN
			-- Is the test input conformed to the class invariant of the target class?
		do
				-- TODO: check the test data is consistent with class invariant
		end

	is_abstract_value (value: STRING_32): BOOLEAN
			-- Is the `value' an abstract value?
		do
			Result := value.has_substring ("T@U")
		end

	is_basic_type (type: STRING_32): BOOLEAN
			-- Is the given type a basic type?
		do

			if type.same_string ("INTEGER") or type.same_string ("INTEGER_32") or
				type.same_string ("NATURAL") or type.same_string ("BOOLEAN") or
				type.same_string ("CHARACTER") or type.same_string ("REAL") then
				Result := True
			else
				Result := False
			end
		end

end

