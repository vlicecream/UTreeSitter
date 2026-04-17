;; inherits: cpp

; 默认配色策略 / Default color strategy:
; - 普通 C++ 尽量沿用继承自 cpp query 的默认语义分组
;   Keep plain C++ on the inherited cpp query semantics.
; - Unreal 宏和预处理风格 token 优先映射到 directive / macro 类 capture
;   Map Unreal macros and preprocessor-like tokens to directive / macro captures.
; - 类型名和 specifier key 优先映射到 type 类 capture
;   Map type names and specifier keys to type-like captures.
; - 函数、方法、字段尽量保持 function / property 层次
;   Keep functions, methods, and fields on function / property style captures.
; - 字符串、数字、布尔值继续使用各自原生 capture
;   Keep strings, numbers, and booleans on their native captures.

; ========================
; C++ 预处理 / C++ Preprocessor
; ========================

(preproc_include) @keyword.directive
(preproc_def) @keyword.directive
(preproc_function_def) @keyword.directive
(preproc_call) @keyword.directive
(preproc_if) @keyword.directive
(preproc_ifdef) @keyword.directive
(preproc_elifdef) @keyword.directive
(preproc_else) @keyword.directive
(preproc_elif) @keyword.directive

(preproc_include
  path: (string_literal) @string.special)

(preproc_include
  path: (system_lib_string) @string.special)

; ========================
; C++ 核心类型 / C++ Core Types / Names
; ========================

(primitive_type) @type.builtin
(type_identifier) @type
(qualified_identifier) @type

; ========================
; Unreal 反射宏 / Unreal Reflection Macros
; ========================

(unreal_class_macro) @keyword.directive
(unreal_struct_macro) @keyword.directive
(unreal_enum_macro) @keyword.directive

(unreal_property_macro) @keyword.directive
(unreal_function_macro) @function.macro

(unreal_umeta_macro) @keyword.directive

(unreal_generated_body_macro) @keyword.directive
(unreal_declare_class_macro) @keyword.directive
(unreal_define_default_object_initializer_macro) @keyword.directive

(unreal_deprecated_macro) @keyword.directive

; ========================
; UE Specifier 参数 / UE Specifiers (Blueprintable, EditAnywhere...)
; ========================

(unreal_specifier
  key: (identifier) @type)

(unreal_specifier
  key: (unreal_specifier_keyword) @type)

(unreal_specifier
  flag: (identifier) @type)

(unreal_specifier
  flag: (unreal_specifier_keyword) @type)

(unreal_specifier
  value: (unreal_specifier_value
    (string_literal) @string))

(unreal_specifier
  value: (unreal_specifier_value
    (number_literal) @number))

(unreal_specifier
  value: (unreal_specifier_value
    [
      (true)
      (false)
    ] @constant.builtin))

(unreal_specifier
  value: (unreal_specifier_value
    (identifier) @constant))

(unreal_specifier
  value: (unreal_specifier_value
    (qualified_unreal_identifier) @type))

(unreal_specifier
  value: (unreal_specifier_value
    (qualified_unreal_type_identifier) @type))

(unreal_specifier
  value: (unreal_specifier_value
    (template_type) @type))

; meta=(Key=Value) 元数据参数 / metadata specifier items
(unreal_meta_specifier_item
  key: (identifier) @type)

(unreal_meta_specifier_item
  key: (unreal_specifier_keyword) @type)

(unreal_meta_specifier_item
  flag: (identifier) @type)

(unreal_meta_specifier_item
  flag: (unreal_specifier_keyword) @type)

(unreal_meta_specifier_item
  value: (unreal_specifier_value
    (string_literal) @string))

(unreal_meta_specifier_item
  value: (unreal_specifier_value
    (number_literal) @number))

(unreal_meta_specifier_item
  value: (unreal_specifier_value
    [
      (true)
      (false)
    ] @constant.builtin))

(unreal_meta_specifier_item
  value: (unreal_specifier_value
    (identifier) @constant))

(unreal_meta_specifier_item
  value: (unreal_specifier_value
    (qualified_unreal_identifier) @type))

(unreal_meta_specifier_item
  value: (unreal_specifier_value
    (qualified_unreal_type_identifier) @type))

(unreal_meta_specifier_item
  value: (unreal_specifier_value
    (template_type) @type))

; ========================
; UE API 宏 / UE API Macro (XXX_API)
; ========================

(unreal_module_api_specifier) @keyword.directive

; FORCEINLINE 内联提示 / FORCEINLINE hint
(unreal_force_inline_specifier) @keyword.function

; ========================
; UE 声明宏 / UE Declaration Macros
; ========================

(unreal_declaration_macro
  name: (unreal_declaration_macro_name) @macro)

; ========================
; 反射类型名 / Reflected Type Names
; ========================

(unreal_reflected_class_declaration
  name: (type_identifier) @type)

(unreal_reflected_struct_declaration
  name: (type_identifier) @type)

(unreal_reflected_enum_declaration
  name: (type_identifier) @type)

(unreal_reflected_class_declaration
  name: (qualified_identifier) @type)

(unreal_reflected_struct_declaration
  name: (qualified_identifier) @type)

(unreal_reflected_enum_declaration
  name: (qualified_identifier) @type)

; ========================
; UE Pragma 指令 / UE Pragmas
; ========================

(unreal_pragma_macro) @keyword.directive

; ========================
; 函数与方法 / Functions and Methods
; ========================

(call_expression
  function: (identifier) @function)

(call_expression
  function: (qualified_identifier
    name: (identifier) @function))

(function_declarator
  declarator: (identifier) @function)

(function_declarator
  declarator: (qualified_identifier
    name: (identifier) @function))

(function_declarator
  declarator: (field_identifier) @function)

(unreal_function_declaration
  declarator: (function_declarator
    declarator: (field_identifier) @function.method))

(field_declaration
  declarator: (field_identifier) @property)

(field_declaration
  declarator: (function_declarator
    declarator: (field_identifier) @function.method))

; ========================
; UE 命名风格类型兜底 / Types (UE naming style fallback)
; ========================

((identifier) @type
 (#match? @type "^[A-Z][A-Za-z0-9_]+$"))

; ========================
; 常量 / Constants
; ========================

(this) @variable.builtin

[
 (null)
 (true)
 (false)
] @constant.builtin

; ========================
; 关键字 / Keywords
; ========================

[
 "class"
 "struct"
 "enum"
 "template"
 "typename"
 "public"
 "private"
 "protected"
 "static"
 "const"
 "inline"
 "return"
 "virtual"
 "override"
 "constexpr"
 "consteval"
 "constinit"
 "noexcept"
] @keyword
