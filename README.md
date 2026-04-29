# UTreeSitter

[English](#english) | [中文](#中文)

---

## English

`UTreeSitter` is a Tree-sitter parser and query pack for Unreal C++.

### Install

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

### What it covers

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

### Quick check

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

### Highlight groups

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

### Local samples

Use the local test fixtures before committing query changes:

- `test/highlight_fixture_unreal.h`
- `test/highlight_fixture_unreal.cpp`

For a quick manual check, put the cursor on a token and run `:Inspect`.

---

## 中文

`UTreeSitter` 是一个面向 Unreal C++ 的 Tree-sitter 解析器和查询包。

### 安装

使用 `lazy.nvim` 安装：

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

如果你同时使用 `UCore.nvim`，它可以帮你处理 Unreal 解析器 / 文件类型绑定和高亮配色。
这种情况下，本仓库只需在 `runtimepath` 上即可。

### 功能覆盖

- 解析器名称 `unreal_cpp`，Unreal 工程缓冲区自动设为 `unreal_cpp` 文件类型
- 查询包包含：
  - `highlights.scm`
  - `locals.scm`
  - `indents.scm`
  - `folds.scm`
  - `injections.scm`
  - `textobjects.scm`
- Unreal 专有捕获覆盖：
  - 反射宏：`UCLASS`, `USTRUCT`, `UENUM`, `UPROPERTY`, `UFUNCTION`, `GENERATED_BODY`
  - 声明宏：`DECLARE_DELEGATE`, `DECLARE_DYNAMIC_MULTICAST_DELEGATE`, `DECLARE_EVENT`
  - 枚举及枚举项
  - 说明符、元数据、辅助调用、成员访问、常用 Unreal 模板类型

### 快速验证

重启 Neovim 后执行：

```vim
:lua print(require("nvim-treesitter.parsers").unreal_cpp and "registered" or "missing")
:set ft?
:InspectTree
```

预期结果：

- 解析器已注册
- 工程内 Unreal 源码文件类型为 `unreal_cpp`
- `:InspectTree` 显示 `unreal_cpp` 解析器
- `:lua print(vim.treesitter.query.get("unreal_cpp", "highlights") and "query ok" or "no query")`
  返回 `query ok`

### 高亮分组

Unreal 查询文件将语法映射为语义捕获，例如：

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

这样查询侧保持语义化，由你的配色方案决定最终颜色。

### 本地测试文件

在提交查询改动前，使用以下本地测试文件验证：

- `test/highlight_fixture_unreal.h`
- `test/highlight_fixture_unreal.cpp`

快速手动检查：将光标放在 token 上，运行 `:Inspect`。
