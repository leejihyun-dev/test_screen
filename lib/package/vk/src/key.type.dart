part of virtual_keyboard;

//키보드 내에 스페이스바, 지우기, 문단띄기 등 정의

/// Type for virtual keyboard key.
///
/// `Action` - Can be action key - Return, Backspace, etc.
///
/// `String` - Keys that have text value - `Letters`, `Numbers`, `@` `.`
enum VirtualKeyboardKeyType { Action, String }

/// Virtual Keyboard key
class VirtualKeyboardKey {
  /// Will the key expand in it's place
  bool willExpand = false;
  String? text;
  String? capsText;
  final VirtualKeyboardKeyType keyType;
  final VirtualKeyboardKeyAction? action;

  VirtualKeyboardKey(
      {this.text, this.capsText, required this.keyType, this.action});
}

/// Shorthand for creating a simple text key
class TextUsKey extends VirtualKeyboardKey {
  //영문은 shift눌렀을 때 대문자 변경 toUpperCase사용해서 올리나보다
  TextUsKey(String text, {String? capsText})
      : super(
            text: text,
            capsText: capsText == null ? text.toUpperCase() : capsText,
            keyType: VirtualKeyboardKeyType.String);
}

class TextKrKey extends VirtualKeyboardKey {
  //한글일때
  TextKrKey(String text, {String? capsText})
      : super(
            text: text,
            capsText: replaceHangul(text.toString(), capsText),
            keyType: VirtualKeyboardKeyType.String);
}

String replaceHangul(String data, String? capsText) {
  //쌍자음 처리
  if (capsText == null) {
    String hangul = switch (data) {
      'ㅂ' => 'ㅃ',
      'ㅈ' => 'ㅉ',
      'ㄷ' => 'ㄸ',
      'ㄱ' => 'ㄲ',
      'ㅅ' => 'ㅆ',
      'ㅐ' => 'ㅒ',
      'ㅔ' => 'ㅖ',
      _ => data,
    };
    return hangul;
  } else {
    return capsText;
  }
}

/// Shorthand for creating action keys
class ActionKey extends VirtualKeyboardKey {
  ActionKey(VirtualKeyboardKeyAction action)
      : super(keyType: VirtualKeyboardKeyType.Action, action: action) {
    switch (action) {
      case VirtualKeyboardKeyAction.Space:
        super.text = '_';
        super.capsText = '_';
        super.willExpand = true;
        break;
      case VirtualKeyboardKeyAction.Backspace:
        super.willExpand = true;
        break;
      default:
        break;
    }
  }
}
