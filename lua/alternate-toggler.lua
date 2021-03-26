local AlternateToggler = {}

local defaultTable = {
  ["true"] = "false",
  ["True"] = "False",
  ["TRUE"] = "FALSE",
  ["Yes"] = "No",
  ["YES"] = "NO",
  ["1"] = "0"
}

local userTable = vim.g.at_custom_alternates or {}

vim.tbl_add_reverse_lookup(defaultTable)
vim.tbl_add_reverse_lookup(userTable)

local mergedTable = vim.tbl_extend("force", defaultTable, userTable)

local function errorHandler(err)
  if not err == nil then
    print("Error toggling to alternate value. Err: "..err)
  end
end

function AlternateToggler.toggleAlternate(str)
  if mergedTable[str] == nil then
    print("Unsupported alternate value.")
    return
  end

  xpcall(vim.cmd('normal ciw'..mergedTable[str]), errorHandler)
end

return AlternateToggler

