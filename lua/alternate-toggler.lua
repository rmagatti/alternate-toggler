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
  ["+"] = "-"
}

-- TODO: add support for lua config through `setup`
local user_table = vim.g.at_custom_alternates or {}

vim.tbl_add_reverse_lookup(default_table)
vim.tbl_add_reverse_lookup(user_table)

local merged_table = vim.tbl_extend("force", default_table, user_table)

local function errorHandler(err)
  if not err == nil then
    print("Error toggling to alternate value. Err: "..err)
  end
end

function AlternateToggler.toggleAlternate(str)
  if merged_table[str] == nil then
    print("Unsupported alternate value.")
    return
  end

  xpcall(vim.cmd('normal ciw'..merged_table[str]), errorHandler)
end

return AlternateToggler
