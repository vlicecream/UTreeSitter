;; inherits: cpp

; ========================
; C++ Preprocessor
; ========================

(preproc_include) @keyword.directive
(preproc_def) @keyword.directive
(preproc_function_def) @keyword.directive
(preproc_call) @keyword.directive
(preproc_if) @keyword.directive
(preproc_ifdef) @keyword.directive
(preproc_else) @keyword.directive
(preproc_elif) @keyword.directive
(preproc_endif) @keyword.directive

(preproc_include
  path: (string_literal) @string.special)

(preproc_include
  path: (system_lib_string) @string.special)

; ========================
; C++ Core Types / Names
; ========================

(primitive_type) @type.builtin
(type_identifier) @type
(qualified_identifier) @type

; ========================
; Unreal Reflection Macros
; ========================

(unreal_class_macro) @attribute
(unreal_struct_macro) @attribute
(unreal_enum_macro) @attribute

(unreal_property_macro) @property
(unreal_function_macro) @function.macro

(unreal_umeta_macro) @attribute

(unreal_generated_body_macro) @macro
(unreal_declare_class_macro) @macro
(unreal_define_default_object_initializer_macro) @macro

(unreal_deprecated_macro) @attribute

; ========================
; UE Specifiers (Blueprintable, EditAnywhere...)
; ========================

(unreal_specifier
  key: (identifier) @attribute)

(unreal_specifier
  key: (unreal_specifier_keyword) @attribute)

(unreal_specifier
  flag: (identifier) @attribute)

(unreal_specifier
  flag: (unreal_specifier_keyword) @attribute)

; meta=(Key=Value)
(unreal_meta_specifier_item
  key: (identifier) @attribute)

(unreal_meta_specifier_item
  key: (unreal_specifier_keyword) @attribute)

; ========================
; UE API Macro (XXX_API)
; ========================

(unreal_module_api_specifier) @type.qualifier

; FORCEINLINE
(unreal_force_inline_specifier) @keyword.function

; ========================
; UE Declaration Macros
; ========================

(unreal_declaration_macro
  name: (unreal_declaration_macro_name) @macro)

; ========================
; Reflected Type Names
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
; UE Pragma
; ========================

(unreal_pragma_macro) @keyword.directive

; ========================
; Functions
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
; Types (UE 风格：大写开头)
; ========================

((identifier) @type
 (#match? @type "^[A-Z][A-Za-z0-9_]+$"))

; ========================
; Constants
; ========================

(this) @variable.builtin

[
 (null)
 (true)
 (false)
] @constant.builtin

; ========================
; Keywords
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
