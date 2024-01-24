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
  //영문은 shift눌렀을 때 대문제 변경 toUpperCase사용해서 올리나보다
  TextUsKey(String text, {String? capsText})
      : super(
            text: text,
            capsText: capsText == null ? text.toUpperCase() : capsText,
            keyType: VirtualKeyboardKeyType.String);
}

class TextKrKey extends VirtualKeyboardKey {
  //한글은 유음처리 어떻게 하나
  TextKrKey(String text, {String? capsText})
      : super(
            text: text,
            // capsText: capsText == null ?  text.toString():  capsText,
            capsText: test(text.toString(), capsText),
            keyType: VirtualKeyboardKeyType.String);
}

String test(String data, String? capsText) {
  print(data);
  if (capsText == null) {
    return data.toUpperCase();
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
        super.text = ' ';
        super.capsText = ' ';
        super.willExpand = true;
        break;
      // case VirtualKeyboardKeyAction.Return:
      //   super.text = '\n';
      //   super.capsText = '\n';
      //   break;
      case VirtualKeyboardKeyAction.Backspace:
        super.willExpand = true;
        break;
      default:
        break;
    }
  }
}
