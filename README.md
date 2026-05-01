# UTreeSitter

[English](#english) | [中文](#中文)

---

## English

`UTreeSitter` is the Tree-sitter grammar and query pack for Unreal C++.

The grammar is built on top of upstream `tree-sitter-cpp`, but it keeps the
separate parser name `unreal_cpp`. That is intentional: plain C++ continues to
use stock `cpp`, while Unreal-specific nodes, queries, and editor integrations
target `unreal_cpp` explicitly.

This repository owns the parser and query source only:

- `grammar.js`
- generated parser sources in `src/`
- bindings under `bindings/`
- `queries/unreal_cpp/*.scm`
- grammar and query fixtures under `test/`

Neovim integration is handled by [`UTreeSitter.nvim`](https://github.com/vlicecream/UTreeSitter.nvim). Normal users do not need to configure this repository directly.

### Development

Generate the parser and run the Node tests:

```powershell
npm test
```

Manual parser/query checks:

```powershell
tree-sitter parse .\test\highlight_unreal.cpp
tree-sitter query .\queries\unreal_cpp\highlights.scm .\test\highlight_unreal.cpp
```

### Query Pack

The query pack contains:

- `highlights.scm`
- `locals.scm`
- `indents.scm`
- `folds.scm`
- `injections.scm`
- `textobjects.scm`

Unreal-specific captures cover reflection macros, declaration macros, enums, enumerators, specifiers, metadata, helper calls, member access, and common Unreal template types.

---

## 中文

`UTreeSitter` 是面向 Unreal C++ 的 Tree-sitter grammar 和 query 包。

这套 grammar 是基于上游 `tree-sitter-cpp` 扩展出来的，但对外仍然保持独立
parser 名称 `unreal_cpp`。这是刻意设计的：普通 C++ 继续使用原生 `cpp`，
而 Unreal 专有节点、query 和编辑器集成则明确指向 `unreal_cpp`。

这个仓库只负责底层 parser 与 query 源码：

- `grammar.js`
- `src/` 下的生成 parser 源码
- `bindings/` 下的语言绑定
- `queries/unreal_cpp/*.scm`
- `test/` 下的 grammar/query 测试固件

Neovim 集成由 [`UTreeSitter.nvim`](https://github.com/vlicecream/UTreeSitter.nvim) 负责。普通用户不需要直接配置这个仓库。

### 开发

生成 parser 并运行 Node 测试：

```powershell
npm test
```

手动检查 parser/query：

```powershell
tree-sitter parse .\test\highlight_unreal.cpp
tree-sitter query .\queries\unreal_cpp\highlights.scm .\test\highlight_unreal.cpp
```

### Query 包

Query 包包含：

- `highlights.scm`
- `locals.scm`
- `indents.scm`
- `folds.scm`
- `injections.scm`
- `textobjects.scm`

Unreal 专有捕获覆盖反射宏、声明宏、枚举、枚举项、说明符、metadata、辅助调用、成员访问和常见 Unreal 模板类型。
