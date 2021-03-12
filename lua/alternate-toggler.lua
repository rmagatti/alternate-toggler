-- helper functions
local function invert_table(t)
  local s = {}
  for k,v in pairs(t) do
    s[v] = k
  end
  return s
end

local function merge_tables(t1, t2)
  local s = {}
  for k,v in pairs(t1) do
    s[k] = v
  end

  for k,v in pairs(t2) do
    s[k] = v
  end
  return s
end
-- end helpers

local AlternateToggler = {}

local defaultTable = {}
defaultTable["true"] = "false"
defaultTable["True"] = "False"
defaultTable["1"] = "0"
local userTable = vim.g.at_custom_alternates

local invertedDefaultTable = invert_table(defaultTable)
local invertedUserTable = invert_table(userTable)
local mergedTable = merge_tables(merge_tables(defaultTable, invertedDefaultTable), merge_tables(userTable, invertedUserTable))

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

