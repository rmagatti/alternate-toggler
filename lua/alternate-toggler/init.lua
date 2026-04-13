local config = require("alternate-toggler.config")

local AlternateToggler = {}

--- Configure alternate-toggler.
---
--- If `conf.alternates` is provided, it fully replaces the default alternates.
--- Each entry must be a list of 2+ strings representing a cycle.
---
--- Example:
--- ```lua
--- require("alternate-toggler").setup({
---   alternates = {
---     { "true", "false" },
---     { "public", "private", "protected" },
---     { "info", "warn", "error", "debug", "trace" },
---   }
--- })
--- ```
---@param conf? { alternates?: string[][] }
function AlternateToggler.setup(conf)
	conf = conf or {}
	if conf.alternates ~= nil then
		if type(conf.alternates) ~= "table" then
			vim.notify("alternate-toggler: setup() expects alternates to be a list of cycles", vim.log.levels.ERROR)
			return
		end
		config.set_alternates(conf.alternates)
	end
end

-- Snapshot/restore helpers to avoid polluting the user's registers and cursor.

local snapshot = {}

local function snapshot_and_clean()
	snapshot.clipboard = vim.o.clipboard
	snapshot.register = vim.fn.getreg('"')
	snapshot.register_mode = vim.fn.getregtype('"')
	snapshot.curpos = vim.api.nvim_win_get_cursor(0)

	vim.o.clipboard = nil
end

local function restore_snapshot()
	vim.fn.setreg('"', snapshot.register, snapshot.register_mode)
	vim.o.clipboard = snapshot.clipboard
	vim.api.nvim_win_set_cursor(0, snapshot.curpos)
end

--- Toggle the word under the cursor to its next alternate value.
function AlternateToggler.toggleAlternate()
	snapshot_and_clean()

	vim.cmd("normal! yiw")
	local yanked_word = vim.fn.getreg('"')
	local lookup = config.get_lookup()
	local next_value = lookup[yanked_word]

	if next_value == nil then
		vim.notify("Unsupported alternate value.", vim.log.levels.INFO)
		restore_snapshot()
		return
	end

	local ok, err = pcall(function()
		vim.cmd("normal! ciw" .. next_value)
	end)

	if not ok then
		vim.notify("Error toggling to alternate value: " .. tostring(err), vim.log.levels.ERROR)
	end

	restore_snapshot()
end

return AlternateToggler
