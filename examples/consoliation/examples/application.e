note
	description: "STVR_examples application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
		    acc1: ACCOUNT; acc2: ACCOUNT_1; acc3: ACCOUNT_2; acc4: ACCOUNT_3; acc5: ACCOUNT_4; acc6: ACCOUNT_5; acc7: ACCOUNT_6
		    bs1: BINARY_SEARCH_1; bs2: BINARY_SEARCH_2; bs3: BINARY_SEARCH_3; bs4: BINARY_SEARCH_4; bs5: BINARY_SEARCH_5; bs6: BINARY_SEARCH_6
            clk1: CLOCK; clk2: CLOCK_2; clk_3: CLOCK_3; clk_4: CLOCK_4; clk_5: CLOCK_5; clk_6: CLOCK_6; clk_7: CLOCK_7
            ht1: HEATER_1; ht2: HEATER_2
            lamp1: LAMP_1; lamp2: LAMP_2; lamp3: LAMP_3; lamp4: LAMP_4
            ls1: LINEAR_SEARCH_1; ls2: LINEAR_SEARCH_2; ls_3: LINEAR_SEARCH_3
            ma1: MAX_IN_ARRAY_1; ma2: MAX_IN_ARRAY_2; ma3: MAX_IN_ARRAY_3; ma4: MAX_IN_ARRAY_4; ma5: MAX_IN_ARRAY_5;
            sr1: SQUARE_ROOT_1; sr2: SQUARE_ROOT_2; sr3: SQUARE_ROOT_3; sr4: SQUARE_ROOT_4
            sum1: SUM_AND_MAX_1; sum2: SUM_AND_MAX_2; sum3: SUM_AND_MAX_3; sum4: SUM_AND_MAX_4; sum5: SUM_AND_MAX_5; sum6: SUM_AND_MAX_6;

		do
			--| Add your code here
			print ("Hello Eiffel World!%N")
		end

end
