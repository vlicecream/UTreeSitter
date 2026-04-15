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

      if type(opts.ensure_installed) == "table" then
        opts.ensure_installed = vim.tbl_filter(function(lang)
          return lang ~= "unreal_cpp"
        end, opts.ensure_installed)
      end

      return opts
    end,
    config = function(_, opts)
      local parsers = require("nvim-treesitter.parsers")

      local function register_unreal_cpp()
        parsers.unreal_cpp = {
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

      register_unreal_cpp()
      require("nvim-treesitter").setup(opts or {})

      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          register_unreal_cpp()
        end,
      })

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
          cpp = function(path) if is_unreal_project(path) then return "unreal_cpp" end end,
          h = function(path) if is_unreal_project(path) then return "unreal_cpp" end end,
          hpp = function(path) if is_unreal_project(path) then return "unreal_cpp" end end,
          hh = function(path) if is_unreal_project(path) then return "unreal_cpp" end end,
          cc = function(path) if is_unreal_project(path) then return "unreal_cpp" end end,
          cxx = function(path) if is_unreal_project(path) then return "unreal_cpp" end end,
          inl = function(path) if is_unreal_project(path) then return "unreal_cpp" end end,
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "unreal_cpp",
        callback = function(args)
          pcall(vim.treesitter.start, args.buf, "unreal_cpp")
        end,
      })
    end,
  },
}
