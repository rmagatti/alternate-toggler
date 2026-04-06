# Alternate Toggler

A small Neovim plugin for cycling between alternate values.

`true` -> `false`, `public` -> `private` -> `protected` -> `public`, or any custom cycle you define.

![](https://github.com/rmagatti/readme-assets/blob/main/alternate-toggler.gif)

## How it works

`:ToggleAlternate` reads the word under the cursor and replaces it with the next value in its cycle.

Every set of alternates is a **cycle** -- a list of values that wrap around:

```
{ "true", "false" }                          -- true -> false -> true
{ "public", "private", "protected" }         -- public -> private -> protected -> public
{ "info", "warn", "error", "debug" }         -- info -> warn -> error -> debug -> info
```

A 2-element cycle is a simple toggle. A 3+ element cycle moves forward through the list, wrapping back to the start.

## Installation

Any plugin manager should do. Example with [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "rmagatti/alternate-toggler",
  keys = {
    { "<leader><space>", "<cmd>ToggleAlternate<CR>", desc = "Toggle alternate" },
  },
  config = function()
    require("alternate-toggler").setup()
  end,
}
```

## Configuration

### Defaults

The plugin works out of the box with these built-in cycles:

```lua
{ "true", "false" }
{ "True", "False" }
{ "TRUE", "FALSE" }
{ "Yes", "No" }
{ "YES", "NO" }
{ "1", "0" }
{ "<", ">" }
{ "(", ")" }
{ "[", "]" }
{ "{", "}" }
{ '"', "'" }
{ '""', "''" }
{ "+", "-" }
{ "===", "!==" }
{ "==", "!=" }
{ "public", "private", "protected" }
```

Calling `setup()` with no arguments keeps these defaults:

```lua
require("alternate-toggler").setup()
```

### Custom cycles

Pass your own cycles via `setup()`. Each cycle is a list of 2+ strings.

```lua
require("alternate-toggler").setup {
  alternates = {
    { "true", "false" },
    { "Yes", "No" },
    { "==", "!=" },
    { "public", "private", "protected" },
    { "info", "warn", "error", "debug", "trace" },
    { "left", "center", "right" },
  }
}
```

> **Note:** Providing `alternates` fully **replaces** the defaults. Include any defaults you want to keep.

## Commands

`:ToggleAlternate` -- cycle the word under the cursor to its next alternate value.

## Migrating from v1

v2 is a breaking change. Alternates are now lists of cycles instead of key-value pairs, and support cycling through 3+ values.

```lua
-- v1 (no longer supported)
setup { alternates = { ["true"] = "false" } }

-- v2
setup { alternates = { { "true", "false" } } }
```

Other changes:
- `vim.g.at_custom_alternates` is removed. Use `setup()` instead.
- The deprecated string argument to `toggleAlternate()` is removed.

## Compatibility

Neovim >= 0.5
