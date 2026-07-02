; Adapted for Helix from dlvandenberg/tree-sitter-angular (nvim queries).
; Helix uses the FIRST matching pattern, so specific rules come before
; generic ones (reverse of nvim ordering).

; inherits: html

; --- pipes ---
(pipe_call
  name: (identifier) @function)

(pipe_call
  arguments: (pipe_arguments
    (identifier) @variable.parameter))

(pipe_operator) @operator

; --- structural directives / bindings ---
(structural_directive
  "*" @keyword
  (identifier) @keyword)

(attribute
  (attribute_name) @variable.other.member
  (#match? @variable.other.member "^#"))

(binding_name
  (identifier) @keyword)

(class_binding
  [
    (identifier)
    (class_name)
  ] @keyword)

(event_binding
  (binding_name
    (identifier) @keyword))

(event_binding
  "\"" @punctuation.delimiter)

(property_binding
  [
    "\""
    "\"\""
  ] @punctuation.delimiter)

(structural_assignment
  operator: (identifier) @keyword)

(two_way_binding
  [
    "[("
    ")]"
  ] @punctuation.bracket)

; --- control flow (@if / @for / @switch / @defer ...) ---
((control_keyword) @keyword.control.repeat
  (#any-of? @keyword.control.repeat "for" "empty"))

((control_keyword) @keyword.control.conditional
  (#any-of? @keyword.control.conditional "if" "else" "switch" "case" "default"))

((control_keyword) @keyword.control.exception
  (#eq? @keyword.control.exception "error"))

[
  (control_keyword)
  (special_keyword)
] @keyword

; --- expressions ---
(member_expression
  property: (identifier) @variable.other.member)

(call_expression
  function: ((identifier) @function.builtin
    (#eq? @function.builtin "$any")))

(call_expression
  function: (identifier) @function)

(pair
  key: ((identifier) @variable.builtin
    (#eq? @variable.builtin "$implicit")))

((identifier) @constant.builtin.boolean
  (#any-of? @constant.builtin.boolean "true" "false"))

((identifier) @variable.builtin
  (#any-of? @variable.builtin "this" "$event"))

((identifier) @constant.builtin
  (#eq? @constant.builtin "null"))

(identifier) @variable

(style_unit) @variable

(string) @string

(template_chars) @string

(number) @constant.numeric

[
  (ternary_operator)
  (conditional_operator)
] @keyword.control.conditional

(nullish_coalescing_expression
  (coalescing_operator) @operator)

(concatenation_expression
  "+" @operator)

(binary_expression
  [
    "-"
    "&&"
    "+"
    "<"
    "<="
    "="
    "=="
    "==="
    "!="
    "!=="
    ">"
    ">="
    "*"
    "/"
    "||"
    "%"
  ] @operator)

(arrow_function
  "=>" @operator)

(object
  (spread
    "..." @operator))

(array
  (spread
    "..." @operator))

(arguments
  (spread
    "..." @operator))

; --- i18n / ICU ---
(icu_clause) @keyword.operator

(icu_category) @keyword.control.conditional

; --- punctuation ---
[
  "{{"
  "}}"
] @punctuation.special

(template_substitution
  [
    "${"
    "}"
  ] @punctuation.special)

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "@"
] @punctuation.bracket

[
  ";"
  "."
  ","
  "?."
  "!."
] @punctuation.delimiter
