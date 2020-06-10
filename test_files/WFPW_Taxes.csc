/* Calculate Payroll Taxes */

'Testing123'
"Hello" = 4 * 5
"Social Security Tax" (
	IF (@ISMBR ("Department General"))
		IF ("CYTD Total Salary" <= "SSTax Cap")
			"Social Security Tax" = "SSTax Rate1" * "Total Employee Salary";
		ELSEIF ("CYTD Total Salary (Prior)" <= "SSTax Cap")
			"Social Security Tax" = "SSTax Rate1" * ("SSTax Cap" - "CYTD Total Salary (Prior)") + "SSTax Rate2" * ("CYTD Total Salary" - "SSTax Cap");
		ELSE
			"Social Security Tax" = "SSTax Rate2" * "Total Employee Salary";
		ENDIF

		"Medicare" = "Total Employee Salary" * "Medicare Rate";
	ELSEIF ("FTE Split" <> "FTE") /* Split Employees */
		IF ("CYTD Total Salary" <= "SSTax Cap")
			"Social Security Tax" = ("SSTax Rate1" * "Total Employee Salary") * "FTE Split";
		ELSEIF ("CYTD Total Salary (Prior)" <= "SSTax Cap")
			"Social Security Tax" = ("SSTax Rate1" * ("SSTax Cap" - "CYTD Total Salary (Prior)") + "SSTax Rate2" * ("CYTD Total Salary" - "SSTax Cap")) * "FTE Split";
		ELSE
			"Social Security Tax" = ("SSTax Rate2" * "Total Employee Salary") * "FTE Split";
		ENDIF

		"Medicare" = ("Total Employee Salary" * "Medicare Rate") * "FTE Split";
	ELSEIF ("FTE Split" == "FTE") /* Non-Split Employees */
		IF ("CYTD Total Salary" <= "SSTax Cap")
			"Social Security Tax" = ("SSTax Rate1" * "Total Employee Salary");
		ELSEIF ("CYTD Total Salary (Prior)" <= "SSTax Cap")
			"Social Security Tax" = ("SSTax Rate1" * ("SSTax Cap" - "CYTD Total Salary (Prior)") + "SSTax Rate2" * ("CYTD Total Salary" - "SSTax Cap"));
		ELSE
			"Social Security Tax" = ("SSTax Rate2" * "Total Employee Salary");
		ENDIF

		"Medicare" = ("Total Employee Salary" * "Medicare Rate");
	ELSE
		"Social Security Tax" = #Missing;
		"Medicare" = #Missing;
	ENDIF
) #MISSING

= 10 


"Social Security Tax - Turnover Adj" (
	"Social Security Tax - Turnover Adj" = "SSTax Rate1" * "Turnover Adjustment";

	"Medicare - Turnover Adj" = "Turnover Adjustment" * "Medicare Rate";
)

"SUI" (
	IF (NOT @ISMBR ("Department General"))
		IF ("FTE Split" <> "FTE") /* Split Employees */
			IF ("CYTD Total Salary" <= "SUI Cap")
				"SUI" = ("SUI Rate" * "Total Employee Salary") * "FTE Split";
			ELSEIF ("CYTD Total Salary (Prior)" <= "SUI Cap")
				"SUI" = ("SUI Rate" * ("SUI Cap" - "CYTD Total Salary (Prior)")) * "FTE Split";
			ELSE
				"SUI" = #MISSING;
			ENDIF
		ELSEIF ("FTE Split" == "FTE") /* Non-Split Employees */
			IF ("CYTD Total Salary" <= "SUI Cap")
				"SUI" = ("SUI Rate" * "Total Employee Salary");
			ELSEIF ("CYTD Total Salary (Prior)" <= "SUI Cap")
				"SUI" = ("SUI Rate" * ("SUI Cap" - "CYTD Total Salary (Prior)"));
			ELSE
				"SUI" = #MISSING;
			ENDIF
		ELSE
			"SUI" = #MISSING;
		ENDIF
	ELSE
		"SUI" = #Missing;
	ENDIF
)

"FUTA" (
	IF (NOT @ISMBR ("Department General"))
		IF ("FTE Split" <> "FTE") /* Split Employees */
			IF ("CYTD Total Salary" <= "FUTA Cap")
				"FUTA" = ("FUTA Rate" * "Total Employee Salary") * "FTE Split";
			ELSEIF ("CYTD Total Salary (Prior)" <= "FUTA Cap")
				"FUTA" = ("FUTA Rate" * ("FUTA Cap" - "CYTD Total Salary (Prior)")) * "FTE Split";
			ELSE
				"FUTA" = #MISSING;
			ENDIF
		ELSEIF ("FTE Split" == "FTE") /* Non-Split Employees */
			IF ("CYTD Total Salary" <= "FUTA Cap")
				"FUTA" = ("FUTA Rate" * "Total Employee Salary");
			ELSEIF ("CYTD Total Salary (Prior)" <= "FUTA Cap")
				"FUTA" = ("FUTA Rate" * ("FUTA Cap" - "CYTD Total Salary (Prior)"));
			ELSE
				"FUTA" = #MISSING;
			ENDIF
		ELSE
			"FUTA" = #Missing;
		ENDIF
	ELSE
		"FUTA" = #Missing;
	ENDIF
)