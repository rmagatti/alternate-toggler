local defaults = require("alternate-toggler.defaults")

local M = {}

--- Compile a list of alternate cycles into a flat lookup table.
--- Each cycle is a list of values. The lookup maps each value to the next
--- value in the cycle, wrapping around at the end.
---
--- Example:
---   compile({ {"a", "b", "c"}, {"x", "y"} })
---   => { a = "b", b = "c", c = "a", x = "y", y = "x" }
---
---@param alternates string[][] List of cycles (each cycle is a list of strings)
---@return table<string, string> lookup Flat mapping from each value to its successor
function M.compile(alternates)
	local lookup = {}
	for _, cycle in ipairs(alternates) do
		if type(cycle) ~= "table" or #cycle < 2 then
			goto continue
		end
		for i = 1, #cycle do
			local current = cycle[i]
			local next_val = cycle[(i % #cycle) + 1]
			lookup[current] = next_val
		end
		::continue::
	end
	return lookup
end

--- The active lookup table. Compiled from defaults on load so the plugin
--- works without an explicit setup() call.
---@type table<string, string>
local lookup = M.compile(defaults)

--- Replace the active lookup table with a freshly compiled one.
---@param alternates string[][] List of cycles
function M.set_alternates(alternates)
	lookup = M.compile(alternates)
end

--- Get the current active lookup table.
---@return table<string, string>
function M.get_lookup()
	return lookup
end

return M
