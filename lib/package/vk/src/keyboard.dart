part of virtual_keyboard;

//키보드 클릭시 처리

/// The default keyboard height. Can we overriden by passing
///  `height` argument to `VirtualKeyboard` widget.
const double _virtualKeyboardDefaultHeight = 300;

const int _virtualKeyboardBackspaceEventPerioud = 250;

/// Virtual Keyboard widget.
class VirtualKeyboard extends StatefulWidget {
  /// Keyboard Type: Should be inited in creation time.
  final VirtualKeyboardType type;

  /// The text controller
  final TextEditingController textController;

  /// Virtual keyboard height. Default is 300
  final double height;

  /// Color for key texts and icons.
  final Color textColor;

  /// Font size for keyboard keys.
  final double fontSize;

  /// The builder function will be called for each Key object.
  final Widget Function(BuildContext context, VirtualKeyboardKey key)? builder;

  /// Set to true if you want only to show Caps letters.
  final bool alwaysCaps;

  VirtualKeyboard(
      {Key? key,
      required this.type,
      required this.textController,
      this.builder,
      this.height = _virtualKeyboardDefaultHeight,
      this.textColor = Colors.black,
      this.fontSize = 20,
      this.alwaysCaps = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VirtualKeyboardState();
  }
}

/// Holds the state for Virtual Keyboard class.
class _VirtualKeyboardState extends State<VirtualKeyboard> {
  late double keyHeight;
  late double keySpacing;
  late double maxRowWidth;

  VirtualKeyboardType? type;
  // The builder function will be called for each Key object.
  Widget Function(BuildContext context, VirtualKeyboardKey key)? builder;
  late double height;
  late double width;
  TextSelection? cursorPosition;
  late TextEditingController textController;
  late Color textColor;
  late double fontSize;
  late bool alwaysCaps;
  // Text Style for keys.
  late TextStyle textStyle;

  // True if shift is enabled.
  bool isShiftEnabled = false;
  HangulInput input = HangulInput(''); //한글 자음모음 합치기 위해 사용

  VirtualKeyboardType _selectedType =
      VirtualKeyboardType.Basic; //특수기호 클릭했을 때 이전에 선택한 언어로 돌아가기위해 사용함

  @override
  void didUpdateWidget(VirtualKeyboard oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      type = widget.type;
      height = widget.height;
      textColor = widget.textColor;
      fontSize = widget.fontSize;
      alwaysCaps = widget.alwaysCaps;

      // Init the Text Style for keys.
      textStyle = TextStyle(
        fontSize: fontSize,
        color: textColor,
      );
    });
  }

  void textControllerEvent() {
    if (textController.selection.toString() != "TextSelection.invalid") {
      cursorPosition = textController.selection;
    } else {
      if (cursorPosition == null) {
        cursorPosition = TextSelection(baseOffset: 0, extentOffset: 0);
      } else {}
    }
  }

  @override
  void initState() {
    super.initState();
    textController = widget.textController;
    type = widget.type;
    height = widget.height;
    textColor = widget.textColor;
    fontSize = widget.fontSize;
    alwaysCaps = widget.alwaysCaps;

    textController.addListener(textControllerEvent);
    input = HangulInput('');

    // Init the Text Style for keys.
    textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      color: textColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    switch (type) {
      //스위치 버튼에 따라 타입 다르게 보임
      case VirtualKeyboardType.Numeric: // 숫자만
        return _keyLayout(numericLayout);
      // case VirtualKeyboardType.Alphanumeric: //숫자+자판
      //   return _keyLayout(krLayout);
      // return _keyLayout(usLayout);
      case VirtualKeyboardType.Symbolic: // 아마도 특수문자?
        return _keyLayout(symbolLayout);
      case VirtualKeyboardType.local: //언어변경 추가해봄
        return _keyLayout(usLayout);
      case VirtualKeyboardType.Basic: //기본 숫자+자판
        return _keyLayout(krLayout);
      default:
        throw new Error();
    }
  }

  Widget _keyLayout(List<List<VirtualKeyboardKey>> layout) {
    //키보드 ui
    // basic
    keySpacing = 8.0;
    double totalSpacing = keySpacing * (layout.length + 1);
    keyHeight = (height - totalSpacing) / layout.length;

    int maxLengthRow = 0;
    for (var layoutRow in layout) {
      if (layoutRow.length > maxLengthRow) {
        maxLengthRow = layoutRow.length;
      }
    }
    maxRowWidth =
        ((maxLengthRow - 1) * keySpacing) + (maxLengthRow * keyHeight);

    return Container(
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _rows(layout),
      ),
    );
  }

  /// Returns the rows for keyboard.
  List<Widget> _rows(List<List<VirtualKeyboardKey>> layout) {
    List<Widget> rows = [];
    for (var rowEntry in layout.asMap().entries) {
      int rowNum = rowEntry.key;
      List<VirtualKeyboardKey> rowKeys = rowEntry.value;

      List<Widget> cols = [];
      for (var colEntry in rowKeys.asMap().entries) {
        int colNum = colEntry.key;
        VirtualKeyboardKey virtualKeyboardKey = colEntry.value;
        Widget keyWidget;

        if (builder == null) {
          switch (virtualKeyboardKey.keyType) {
            case VirtualKeyboardKeyType.String: //자음,모음
              keyWidget = _keyboardDefaultKey(virtualKeyboardKey);
              break;
            case VirtualKeyboardKeyType.Action: //기타 버튼
              keyWidget = _keyboardDefaultActionKey(virtualKeyboardKey);
              break;
          }
        } else {
          // Call the builder function, so the user can specify custom UI for keys.
          keyWidget = builder!(context, virtualKeyboardKey);

          throw 'builder function must return Widget';
        }
        cols.add(keyWidget);

        // space between keys
        if (colNum != rowKeys.length - 1) {
          cols.add(SizedBox(
            width: keySpacing,
          ));
        }
      }
      rows.add(Material(
          color: Colors.transparent,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxRowWidth),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: cols),
          )));

      if (rowNum != layout.length - 1) {
        //자판 간 간격 조정
        rows.add(SizedBox(
          height: keySpacing,
        ));
      }
    }
    return rows;
  }

  late bool longPress;

  Widget _keyboardDefaultKey(VirtualKeyboardKey key) {
    //자판
    return Material(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: InkWell(
          highlightColor: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          onTap: () {
            _onKeyPress(key);
          },
          child: Container(
            width: keyHeight,
            height: keyHeight,
            child: Center(
                child: Text(
              alwaysCaps
                  ? key.capsText!
                  : (isShiftEnabled ? key.capsText! : key.text!),
              style: textStyle,
            )),
          ),
        ));
  }

  void _onKeyPress(VirtualKeyboardKey key) {
    //자음,모음(String)을 눌렀는지 다른 버튼(Action)을 눌렀는지

    if (key.keyType == VirtualKeyboardKeyType.String) {
      input.pushCharacter(isShiftEnabled ? key.capsText! : key.text!);
      if (textController.text.endsWith('_')) {
        //TODO. 수정필요~~
        textController.text += input.text;
      } else {
        textController.text = input.text;
      }
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace: //지움 버튼
          input.backspaceChar();
          textController.text = input.text;
          break;
        case VirtualKeyboardKeyAction.Space: //공백추가
          input = HangulInput('');
          textController.text += key.text!;
          break;
        case VirtualKeyboardKeyAction.Shift: //대문자변경
          break;
        case VirtualKeyboardKeyAction.Alpha: //특수기호
          //특수기호 눌렀다가 다시 한글/영어로 변경할 경우
          setState(() {
            type = _selectedType; //이전에 선택했던 언어로 바뀌게 해준다.
          });
          break;
        case VirtualKeyboardKeyAction.Symbols: //특수기호
          setState(() {
            type = VirtualKeyboardType.Symbolic;
          });
          break;
        case VirtualKeyboardKeyAction.local: //언어변경

          setState(() {
            if (isShiftEnabled) {
              //시프트가 눌린채로 언어변경시 기본(자음/소문자)으로 바꿔준다.
              isShiftEnabled = false;
            }
            type = (type == VirtualKeyboardType.local) //영어로 설정됐다면 다시 기본으로
                ? VirtualKeyboardType.Basic
                : VirtualKeyboardType.local; //한글이라면 영어로 변경
            _selectedType = type!;
          });
          break;
        default:
      }
    }
  }

  // void _onKeyPress(VirtualKeyboardKey key) {
  //   if (key.keyType == VirtualKeyboardKeyType.String) {
  //     textController.text += (isShiftEnabled ? key.capsText! : key.text!);
  //   } else if (key.keyType == VirtualKeyboardKeyType.Action) {
  //     switch (key.action) {
  //       case VirtualKeyboardKeyAction.Backspace:
  //         if (textController.text.length == 0) return;
  //         textController.text =
  //             textController.text.substring(0, textController.text.length - 1);
  //         break;
  //       // case VirtualKeyboardKeyAction.Return:
  //       //   textController.text += '\n';
  //       //   break;
  //       case VirtualKeyboardKeyAction.Space:
  //         textController.text += key.text!;
  //         break;
  //       case VirtualKeyboardKeyAction.Shift:
  //         break;
  //       default:
  //     }
  //   }
  // }

  /// Creates default UI element for keyboard Action Key.
  Widget _keyboardDefaultActionKey(VirtualKeyboardKey key) {
    // Holds the action key widget.
    Widget actionKey;

    // Switch the action type to build action Key widget.
    switch (key.action!) {
      case VirtualKeyboardKeyAction.Backspace:
        actionKey = GestureDetector(
            onLongPress: () {
              longPress = true;
              Timer.periodic(
                  Duration(milliseconds: _virtualKeyboardBackspaceEventPerioud),
                  (timer) {
                if (longPress) {
                  _onKeyPress(key);
                } else {
                  // Cancel timer.
                  timer.cancel();
                }
              });
            },
            onLongPressUp: () {
              longPress = false;
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Icon(
                Icons.backspace,
                color: textColor,
              ),
            ));
        break;
      case VirtualKeyboardKeyAction.Shift:
        actionKey = Icon(Icons.arrow_upward,
            color: isShiftEnabled ? Colors.blue : textColor);
        break;
      case VirtualKeyboardKeyAction.Space:
        actionKey = Icon(Icons.space_bar, color: textColor);
        break;
      case VirtualKeyboardKeyAction.local:
        actionKey = Icon(Icons.g_translate_sharp, color: textColor);
        break;
      case VirtualKeyboardKeyAction.Symbols:
        actionKey = Icon(Icons.emoji_symbols, color: textColor);
        break;
      case VirtualKeyboardKeyAction.Alpha:
        actionKey = Icon(Icons.sort_by_alpha, color: textColor);
        break;
    }
    var finalKey = Material(
      color: Colors.grey,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        highlightColor: Colors.blue,
        onTap: () {
          if (key.action == VirtualKeyboardKeyAction.Shift) {
            if (!alwaysCaps) {
              setState(() {
                isShiftEnabled = !isShiftEnabled;
              });
            }
          }

          _onKeyPress(key);
        },
        child: Container(
          width: keyHeight,
          height: keyHeight,
          child: actionKey,
        ),
      ),
    );

    if (key.willExpand) {
      return Expanded(child: finalKey);
    } else {
      return finalKey;
    }
  }
}
