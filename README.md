# Alternate Toggler
Alternate Toggler is a _very_ small plugin for toggling alternate "boolean" values.

<img src="https://github.com/rmagatti/readme-assets/blob/main/alternate-toggler.gif" width="1000" />

# Usage
`:ToggleAlternate` toggles the current word (<cword>) based on a pre-defined map of alternates.

# Installation
Any plugin manager should do, I use [Plug](https://github.com/junegunn/vim-plug).

`Plug 'rmagatti/alternate-toggler'`

# Configuration

### Defaults
This plugin provides a few pre-defined alternate mappings.
```json
{
  "true": "false",
  "True": "False",
  "1": "0",
}
```

### Custom
You can add more alternates through a global config variable:
```viml
let g:at_custom_alternates = {'Yes': 'No'}
```
:warning: WARNING: anything added here will override existing values if the key of the dic is the same as any of the defaults.

# Commands
Alternate Toggler exposes a single `:ToggleAlternate` command.

**Example mapping:**
```viml
nnoremap <leader>ta :ToggleAlternate<CR>
```

# Compatibility
Neovim > 0.5

Tested with:
```
NVIM v0.5.0-dev+a1ec36f
Build type: Release
LuaJIT 2.1.0-beta3
```
