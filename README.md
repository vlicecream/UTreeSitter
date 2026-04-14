# UTreeSitter

Unreal C++ tree-sitter parser focused on common UE4/UE5 reflection syntax such as `UCLASS`, `USTRUCT`, `UENUM`, `UPROPERTY`, `UFUNCTION`, `UMETA`, `GENERATED_BODY`, and common `DECLARE_*` macros.

This repository is a parser repo only. It does not ship Neovim runtime glue in `lua/` or `plugin/`.

## Neovim

After pushing this repository to GitHub, register it from your own Neovim config.

### `lazy.nvim`

```lua
{
  "your-github-name/UTreeSitter",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

    parser_config.unrealcpp = {
      install_info = {
        url = "https://github.com/your-github-name/UTreeSitter",
        files = { "src/parser.c", "src/scanner.c" },
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
      },
      filetype = "unrealcpp",
    }

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

    vim.filetype.add({
      extension = {
        cpp = function(path) if is_unreal_project(path) then return "unrealcpp" end end,
        h = function(path) if is_unreal_project(path) then return "unrealcpp" end end,
        hpp = function(path) if is_unreal_project(path) then return "unrealcpp" end end,
        hh = function(path) if is_unreal_project(path) then return "unrealcpp" end end,
        cc = function(path) if is_unreal_project(path) then return "unrealcpp" end end,
        cxx = function(path) if is_unreal_project(path) then return "unrealcpp" end end,
        inl = function(path) if is_unreal_project(path) then return "unrealcpp" end end,
      },
    })
  end,
}
```

Then run:

```vim
:TSInstall unrealcpp
```

## Validation

Open an Unreal project `.cpp` or `.h` file and check:

1. `:set ft?` shows `filetype=unrealcpp`
2. `:InspectTree` shows nodes like `unreal_reflected_class_declaration`
3. `:Inspect` on `UCLASS`, `UPROPERTY`, `Health`, or `ApplyDamage` shows captures from `unrealcpp`

## Queries

Neovim highlight queries live at:

- `queries/unrealcpp/highlights.scm`

The sample Unreal coverage file lives at:

- `Test/Unreal.cpp`
