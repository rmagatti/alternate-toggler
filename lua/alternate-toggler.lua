local AlternateToggler = {}

local default_table = {
	["true"] = "false",
	["True"] = "False",
	["TRUE"] = "FALSE",
	["Yes"] = "No",
	["YES"] = "NO",
	["1"] = "0",
	["<"] = ">",
	["("] = ")",
	["["] = "]",
	["{"] = "}",
	['"'] = "'",
	['""'] = "''",
	["+"] = "-",
	["==="] = "!==",
	["=="] = "!="
}

local user_table = vim.g.at_custom_alternates or {}

for k, v in pairs(default_table) do
	default_table[v] = k
end

for k, v in pairs(user_table) do
	user_table[v] = k
end

local merged_table = vim.tbl_extend("force", default_table, user_table)

local function errorHandler(err)
	if not err == nil then
		vim.notify("Error toggling to alternate value. Err: " .. err, vim.log.levels.ERROR)
	end
end

function AlternateToggler.setup(conf)
	if type(conf.alternates) == "table" then
		for k, v in pairs(conf.alternates) do
		  conf.alternates[v] = k
		end
		merged_table = vim.tbl_extend("force", merged_table, conf.alternates)
	end
end

local user_clipboard = nil
local user_register = nil
local user_register_mode = nil
local curpos = nil

local function snapshot_and_clean()
	user_clipboard = vim.o.clipboard
	user_register = vim.fn.getreg('"')
	user_register_mode = vim.fn.getregtype('"')
	curpos = vim.api.nvim_win_get_cursor(0)

	vim.o.clipboard = nil
end

local function restore_snapshot()
	vim.fn.setreg('"', user_register, user_register_mode)
	vim.o.clipboard = user_clipboard
	vim.api.nvim_win_set_cursor(0, curpos)
end

function AlternateToggler.toggleAlternate(str)
	if str ~= nil then
		vim.notify(
			"Deprecated: passing a string (usually <cword>) into `toggleAlternate` is deprecated. It now automatically does a `iw` text object operation.",
			vim.log.levels.WARN
		)
	end

	snapshot_and_clean()

	vim.cmd("normal! yiw")
	local yanked_word = vim.fn.getreg('"')
	local word = merged_table[yanked_word]

	if word == nil then
		vim.notify("Unsupported alternate value.", vim.log.levels.INFO)
		restore_snapshot()
		return
	end

	xpcall(function()
		vim.cmd("normal! ciw" .. word)
	end, errorHandler)

	restore_snapshot()
end

return AlternateToggler
