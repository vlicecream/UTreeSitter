# UTreeSitter

`UTreeSitter` is a Tree-sitter parser and query pack for Unreal C++.

## Install

Use `lazy.nvim` like this:

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
    opts = function(_, opts)
      opts = opts or {}
      opts.auto_install = true
      opts.ensure_installed = opts.ensure_installed or {}

      if not vim.tbl_contains(opts.ensure_installed, "unreal_cpp") then
        table.insert(opts.ensure_installed, "unreal_cpp")
      end

      return opts
    end,
  },
}
```

If you also use `UCore.nvim`, it can handle the Unreal parser/filetype hookup
and highlight palette for you. In that setup, this repository only needs to be
on `runtimepath`.

## What it covers

- Unreal project buffers become `unreal_cpp`
- The parser name is `unreal_cpp`
- The query pack covers:
  - `highlights.scm`
  - `locals.scm`
  - `indents.scm`
  - `folds.scm`
  - `injections.scm`
  - `textobjects.scm`
- Unreal-specific captures cover:
  - reflection macros like `UCLASS`, `USTRUCT`, `UENUM`, `UPROPERTY`, `UFUNCTION`, `GENERATED_BODY`
  - declaration macros like `DECLARE_DELEGATE`, `DECLARE_DYNAMIC_MULTICAST_DELEGATE`, and `DECLARE_EVENT`
  - enums and enumerators
  - specifiers, metadata, helper calls, member access, and common Unreal template types

## Quick check

Restart Neovim and run:

```vim
:lua print(require("nvim-treesitter.parsers").unreal_cpp and "registered" or "missing")
:set ft?
:InspectTree
```

Expected results:

- `unreal_cpp` is registered
- Unreal source files inside a project use `ft=unreal_cpp`
- `:InspectTree` reports the `unreal_cpp` parser
- `:lua print(vim.treesitter.query.get("unreal_cpp", "highlights") and "query ok" or "no query")`
  returns `query ok`

## Highlight groups

The Unreal query file maps syntax into semantic captures such as:

- `@keyword.directive.unreal_cpp`
- `@keyword.function.unreal_cpp`
- `@type.unreal_cpp`
- `@type.enum.unreal_cpp`
- `@function.unreal_cpp`
- `@function.method.unreal_cpp`
- `@function.macro.unreal_cpp`
- `@function.macro.delegate.unreal_cpp`
- `@property.unreal_cpp`
- `@variable.unreal_cpp`
- `@constant.unreal_cpp`
- `@constant.enum.unreal_cpp`
- `@parameter.unreal_cpp`
- `@string.unreal_cpp`
- `@number.unreal_cpp`

That keeps the query side semantic and lets your colorscheme decide the final
palette.

## Local samples

Use the local test fixtures before committing query changes:

- `test/highlight_fixture_unreal.h`
- `test/highlight_fixture_unreal.cpp`

For a quick manual check, put the cursor on a token and run `:Inspect`.
