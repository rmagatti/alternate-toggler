# Alternate Toggler
Alternate Toggler is a _very_ small plugin for toggling alternate "boolean" values.

![](https://github.com/rmagatti/readme-assets/blob/main/alternate-toggler.gif)

# Usage
`:ToggleAlternate` toggles the current word (<cword>) based on a pre-defined map of alternates.

# Installation
Any plugin manager should do, I use [Packer](https://github.com/wbthomason/packer.nvim).

```lua
use {
  'rmagatti/alternate-toggler',
  config = function()
    require("alternate-toggler").setup {
      alternates = {
        ["=="] = "!="
      }
    }
    
    vim.keymap.set(
      "n",
      "<leader><space>", -- <space><space>
      "<cmd>lua require('alternate-toggler').toggleAlternate()<CR>"
    )
  end,
  event = { "BufReadPost" }, -- lazy load after reading a buffer
}
```

# Configuration

### Defaults
This plugin provides a few pre-defined alternate mappings.
```lua
{
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
	["==="] = "!=="
}
```

### Custom
You can add more alternates through a global config variable:
```viml
let g:at_custom_alternates = {'===': '!=='}
```

Or through calling the `setup` method of the plugin passing in an `alternates` table in the config.
```lua
require("alternate-toggler").setup {
  alternates = {
    ["==="] = "!==",
    ["=="] = "!=",
  }
}
```
:warning: WARNING: anything added here will override existing values if the key of the dict/table is the same as any of the defaults.

# Commands
Alternate Toggler exposes a single `:ToggleAlternate` command.

**Example mappings:**
```viml
nnoremap <leader>ta :ToggleAlternate<CR>
```
**OR**
```viml
augroup AlternateToggles
  au!
  au FileType typescript,viml,lua nnoremap <buffer> <CR> :ToggleAlternate<CR>
augroup end
```
This allows for merely hitting the enter key to toggle an alternate, the caveat is having to specify supported file types manually.

# Compatibility
Neovim > 0.5

Tested with:
```
NVIM v0.5.0-dev+a1ec36f
Build type: Release
LuaJIT 2.1.0-beta3
```
