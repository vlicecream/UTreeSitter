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
