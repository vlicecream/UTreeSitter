# UTreeSitter

Tree-sitter grammar and query source for Unreal Engine C++.

[English](#english) | [中文](#中文)

---

## English

`UTreeSitter` is the source repository for the `unreal_cpp` tree-sitter grammar.

This repository owns the parser and query source only:

- `grammar.js`
- generated parser files under `src/`
- bindings under `bindings/`
- queries under `queries/unreal_cpp/`
- fixtures under `test/`

Normal Neovim users should install [`UTreeSitter.nvim`](https://github.com/vlicecream/UTreeSitter.nvim), not this repository directly.

### Why `unreal_cpp` Instead of `cpp`

The grammar builds on top of upstream `tree-sitter-cpp`, but keeps a separate parser name:

- plain C++ can stay on upstream `cpp`
- Unreal-specific nodes and queries can target `unreal_cpp`
- Neovim integrations can distinguish Unreal-aware behavior cleanly

### Repository Split

```text
UTreeSitter                  grammar + queries + parser tests
UTreeSitter.nvim             Neovim parser/filetype/highlight integration
UVersionControlSystem.nvim   Unreal VCS dashboard and actions
UCore.nvim                   Unreal project index, RPC, navigation, completion
```

### Development

Install dependencies and run the parser tests:

```powershell
npm test
```

Manual checks:

```powershell
tree-sitter parse .\test\highlight_unreal.cpp
tree-sitter query .\queries\unreal_cpp\highlights.scm .\test\highlight_unreal.cpp
```

### Query Pack

`queries/unreal_cpp/` currently contains:

- `highlights.scm`
- `locals.scm`
- `indents.scm`
- `folds.scm`
- `injections.scm`
- `textobjects.scm`

The captures focus on Unreal macros, reflection metadata, specifiers, enums, helper calls, member access, and common engine types.

### License

MIT

---

## 中文

`UTreeSitter` 是 `unreal_cpp` tree-sitter grammar 的源码仓库。

这个仓库只负责 parser 和 query 源码：

- `grammar.js`
- `src/` 下的生成 parser 文件
- `bindings/` 下的绑定
- `queries/unreal_cpp/` 下的 query
- `test/` 下的测试固件

普通 Neovim 用户应该安装 [`UTreeSitter.nvim`](https://github.com/vlicecream/UTreeSitter.nvim)，而不是直接加载这个仓库。

### 为什么用 `unreal_cpp` 而不是 `cpp`

这套 grammar 建立在上游 `tree-sitter-cpp` 之上，但仍然保留独立 parser 名称：

- 普通 C++ 继续使用上游 `cpp`
- Unreal 专有节点和 query 可以明确指向 `unreal_cpp`
- Neovim 集成层也能清晰地区分 Unreal 专属行为

### 仓库拆分

```text
UTreeSitter                  grammar + queries + parser tests
UTreeSitter.nvim             Neovim parser/filetype/highlight integration
UVersionControlSystem.nvim   Unreal VCS dashboard and actions
UCore.nvim                   Unreal project index, RPC, navigation, completion
```

### 开发

安装依赖并运行 parser 测试：

```powershell
npm test
```

手动检查：

```powershell
tree-sitter parse .\test\highlight_unreal.cpp
tree-sitter query .\queries\unreal_cpp\highlights.scm .\test\highlight_unreal.cpp
```

### Query 包

当前 `queries/unreal_cpp/` 包含：

- `highlights.scm`
- `locals.scm`
- `indents.scm`
- `folds.scm`
- `injections.scm`
- `textobjects.scm`

这些捕获主要覆盖 Unreal 宏、反射 metadata、specifiers、枚举、辅助调用、成员访问和常见引擎类型。

### 许可

MIT
