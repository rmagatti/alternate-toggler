--- Default alternate value cycles for alternate-toggler.
--- Each entry is a list of values to cycle through.
--- A 2-element list behaves as a toggle (A -> B -> A).
--- A 3+ element list cycles forward (A -> B -> C -> A).
return {
	{ "true", "false" },
	{ "True", "False" },
	{ "TRUE", "FALSE" },
	{ "Yes", "No" },
	{ "YES", "NO" },
	{ "1", "0" },
	{ "<", ">" },
	{ "(", ")" },
	{ "[", "]" },
	{ "{", "}" },
	{ '"', "'" },
	{ '""', "''" },
	{ "+", "-" },
	{ "===", "!==" },
	{ "==", "!=" },
	{ "public", "private", "protected" },
}
