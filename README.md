# UTreeSitter

`UTreeSitter` is a Tree-sitter parser for Unreal C++.

## lazy.nvim

Use this when you want to install `UTreeSitter` from GitHub and have Unreal
project files automatically switch to the `unreal_cpp` parser.

```lua
return {
  {
    "vlicecream/UTreeSitter",
    lazy = false,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    init = function()
      local function register_unreal_cpp()
        require("nvim-treesitter.parsers").unreal_cpp = {
          install_info = {
            url = "https://github.com/vlicecream/UTreeSitter",
            files = { "src/parser.c", "src/scanner.c" },
            queries = "queries/unreal_cpp",
            generate_requires_npm = false,
            requires_generate_from_grammar = false,
          },
          filetype = "unreal_cpp",
        }
      end

      local function is_unreal_project(path)
        local markers = vim.fs.find(function(name)
          return name:match("%.uproject$") or name:match("%.uplugin$")
        end, {
          path = vim.fs.dirname(path),
          upward = true,
          type = "file",
          limit = 1,
        })
        return #markers > 0
      end

      register_unreal_cpp()

      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          register_unreal_cpp()
        end,
      })

      vim.filetype.add({
        extension = {
          cpp = function(path)
            if is_unreal_project(path) then
              return "unreal_cpp"
            end
          end,
          h = function(path)
            if is_unreal_project(path) then
              return "unreal_cpp"
            end
          end,
          hpp = function(path)
            if is_unreal_project(path) then
              return "unreal_cpp"
            end
          end,
          hh = function(path)
            if is_unreal_project(path) then
              return "unreal_cpp"
            end
          end,
          cc = function(path)
            if is_unreal_project(path) then
              return "unreal_cpp"
            end
          end,
          cxx = function(path)
            if is_unreal_project(path) then
              return "unreal_cpp"
            end
          end,
          inl = function(path)
            if is_unreal_project(path) then
              return "unreal_cpp"
            end
          end,
        },
      })
    end,
    opts = function(_, opts)
      opts = opts or {}
      opts.auto_install = true

      if opts.ensure_installed == nil then
        opts.ensure_installed = { "unreal_cpp" }
      elseif type(opts.ensure_installed) == "table" and not vim.tbl_contains(opts.ensure_installed, "unreal_cpp") then
        table.insert(opts.ensure_installed, "unreal_cpp")
      end

      return opts
    end,
  },
}
```

## Example plugin spec

If you prefer to keep a copyable plugin file in your config, use
[`examples/lazy.nvim/utreesitter.lua`](examples/lazy.nvim/utreesitter.lua).

## Requirements

- Neovim 0.12 or newer
- `git`
- `curl`
- `tar`
- a working C compiler

## Expected behavior

- Files with extensions `cpp`, `h`, `hpp`, `hh`, `cc`, `cxx`, and `inl` keep
  their normal filetype outside Unreal projects.
- If Neovim finds a `.uproject` or `.uplugin` while scanning upward from the
  file's directory, that buffer becomes `unreal_cpp`.
- `nvim-treesitter` installs `unreal_cpp` from `vlicecream/UTreeSitter`.
- `UTreeSitter` provides the `queries/unreal_cpp` highlights at runtime.

## Quick check

After installing the plugins, restart Neovim and run:

- `:lua print(require("nvim-treesitter.parsers").unreal_cpp and "registered" or "missing")`
- `:TSInstall! unreal_cpp`

Then open a C++ file inside an Unreal project and verify:

- `:set ft?` returns `unreal_cpp`
- `:InspectTree` reports the `unreal_cpp` parser
- `:lua print(vim.treesitter.query.get("unreal_cpp", "highlights") and "query ok" or "no query")`
- Unreal macros such as `UCLASS`, `UPROPERTY`, `UFUNCTION`,
  `GENERATED_BODY`, and specifiers like `Blueprintable` and `EditAnywhere`
  receive Tree-sitter highlighting

## Highlighting model

`UTreeSitter` provides Tree-sitter captures, not fixed colors. The
`queries/unreal_cpp/highlights.scm` file maps Unreal C++ syntax to semantic
groups such as `@keyword.directive`, `@type`, `@function.method`, `@property`,
`@string`, and `@number`. Your colorscheme decides the final color for those
groups.

The default query keeps normal C++ highlighting through `;; inherits: cpp`, then
adds Unreal-specific captures for:

- reflection macros such as `UCLASS`, `USTRUCT`, `UPROPERTY`, `UFUNCTION`, and
  `GENERATED_BODY`
- macro specifier keys and values, including `meta=(BindWidget)`,
  `Category="UI"`, `ClampMin="0"`, and boolean values
- Unreal API/export macros such as `MYMODULE_API`
- Unreal-style type names such as `AActor`, `UUserWidget`, `FText`, `TArray`,
  `TMap`, and `TSoftObjectPtr`
- member access and calls such as `Title->SetText(...)` and
  `CreateWidget<UWidget>(...)`

## Rider-like colors

If you want a Rider-like visual style, keep the query captures as-is and add
colors in your own Neovim config. Example:

```lua
local set = vim.api.nvim_set_hl

set(0, "@keyword.unreal_cpp", { fg = "#6A9BFF" })
set(0, "@keyword.directive.unreal_cpp", { fg = "#6A9BFF" })
set(0, "@keyword.function.unreal_cpp", { fg = "#6A9BFF" })

set(0, "@type.unreal_cpp", { fg = "#C792EA" })
set(0, "@type.builtin.unreal_cpp", { fg = "#C792EA" })
set(0, "@type.qualifier.unreal_cpp", { fg = "#6A9BFF" })

set(0, "@function.unreal_cpp", { fg = "#4EC9B0" })
set(0, "@function.method.unreal_cpp", { fg = "#4EC9B0" })
set(0, "@function.macro.unreal_cpp", { fg = "#6A9BFF" })
set(0, "@property.unreal_cpp", { fg = "#4EC9B0" })

set(0, "@string.unreal_cpp", { fg = "#D7BA7D" })
set(0, "@string.special.unreal_cpp", { fg = "#D7BA7D" })
set(0, "@number.unreal_cpp", { fg = "#F78CBA" })
set(0, "@constant.unreal_cpp", { fg = "#F78CBA" })
set(0, "@constant.builtin.unreal_cpp", { fg = "#F78CBA" })
```

Reload your colorscheme after changing highlight overrides, or put the snippet
inside a `ColorScheme` autocmd so it is re-applied whenever the theme changes.

## Local highlight fixtures

Use these files as stable local samples before committing query changes:

- `test/highlight_fixture_unreal.h`
- `test/highlight_fixture_unreal.cpp`

For each important token, place the cursor on it and run `:Inspect`. The target
is to preserve normal C++ captures while layering Unreal captures on top.
