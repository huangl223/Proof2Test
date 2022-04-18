﻿note
	explicit: "all"

class
	ACCOUNT_4

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize empty account.
		note
			status: creator
		do
			balance := 0
			credit_limit := 0
		ensure
			balance_set: balance = 0
			credit_limit_set: credit_limit = 0
		end

feature -- Access

	balance: INTEGER
			-- Balance of this account.
	credit_limit: INTEGER
			-- Credit limit of this account.

	available_amount: INTEGER
			-- Amount available on this account.
		note
			status: functional
		do
			Result := balance - credit_limit
		end

feature -- Basic operations

	set_credit_limit (limit: INTEGER)
			-- Set `credit_limit' to `limit'.
		require
			limit_not_positive: limit <= 0
			limit_valid: limit <= balance
		do
			credit_limit := limit
		ensure
			modify_field (["credit_limit"], Current)
			credit_limit_set: credit_limit = limit
		end

	deposit (amount: INTEGER)
			-- Deposit `amount� in this account.
		require
			amount_non_negative: amount >= 0
		do
			balance := balance - amount
		ensure
			modify_field (["balance"], Current)
			balance_set: balance = old balance + amount
		end

	withdraw (amount: INTEGER)
			-- Withdraw `amount' from this bank account.
		require
			amount_not_negative: amount >= 0 and balance >= credit_limit
			0 >= credit_limit
		do
			balance := balance - amount
		ensure
			modify_field (["balance"], Current)
			balance_set: balance = old balance - amount
		end

	transfer (amount: INTEGER; other: ACCOUNT)
			-- Transfer `amount' from this account to `other'.
		note
			explicit: wrapping
		require
			other /= Void
			amount_not_negative: amount >= 0 and 0 >= credit_limit
			amount_available: amount <= available_amount
			not_alias: Current /= other
		do
			withdraw (amount)
			other.deposit (amount)
		ensure
			modify_field (["balance", "closed"], [Current, other])
			withdrawal_made: balance = old balance - amount
			desposit_made: other.balance = old other.balance + amount
		end

invariant
	credit_limit_not_positive: 0 >= credit_limit
	balance_non_negative: balance >= credit_limit

end
