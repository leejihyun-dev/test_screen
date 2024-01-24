part of virtual_keyboard;

//키보드 숫자버전, 숫자+글자버전, 숫자+특수기호버전 으로 나뉨 언어변경 추가함

/// Available Virtual Keyboard Types:
/// `Numeric` - Numeric only.
/// `Alphanumeric` - Alphanumeric: letters`[A-Z]` + numbers`[0-9]` + `@` + `.`.
enum VirtualKeyboardType {
  Numeric,
  Basic,
  Symbolic,
  local
} //Alphanumeric -> Basic으로 변경
