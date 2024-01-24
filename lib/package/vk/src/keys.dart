part of virtual_keyboard;

//키보드 UI

/// 영문 키보드
List<List<VirtualKeyboardKey>> usLayout = [
  // Row 1
  [
    TextUsKey(
      "q",
    ),
    TextUsKey(
      "w",
    ),
    TextUsKey(
      "e",
    ),
    TextUsKey(
      "r",
    ),
    TextUsKey(
      "t",
    ),
    TextUsKey(
      "y",
    ),
    TextUsKey(
      "u",
    ),
    TextUsKey(
      "i",
    ),
    TextUsKey(
      "o",
    ),
    TextUsKey(
      "p",
    ),
  ],
  // Row 2
  [
    TextUsKey(
      "a",
    ),
    TextUsKey(
      "s",
    ),
    TextUsKey(
      "d",
    ),
    TextUsKey(
      "f",
    ),
    TextUsKey(
      "g",
    ),
    TextUsKey(
      "h",
    ),
    TextUsKey(
      "j",
    ),
    TextUsKey(
      "k",
    ),
    TextUsKey(
      "l",
    ),
  ],
  // Row 3
  [
    ActionKey(VirtualKeyboardKeyAction.Shift),
    TextUsKey(
      "z",
    ),
    TextUsKey(
      "x",
    ),
    TextUsKey(
      "c",
    ),
    TextUsKey(
      "v",
    ),
    TextUsKey(
      "b",
    ),
    TextUsKey(
      "n",
    ),
    TextUsKey(
      "m",
    ),
    ActionKey(VirtualKeyboardKeyAction.Backspace),
  ],
  // Row 4
  [
    ActionKey(VirtualKeyboardKeyAction.Symbols),
    TextUsKey(','),
    ActionKey(VirtualKeyboardKeyAction.Space),
    TextUsKey('.'),
    ActionKey(VirtualKeyboardKeyAction.local),
  ]
];

/// 한국어 키보드
List<List<VirtualKeyboardKey>> krLayout = [
  // Row 1
  [
    TextKrKey(
      "ㅂ",
    ),
    TextKrKey(
      "ㅈ",
    ),
    TextKrKey(
      "ㄷ",
    ),
    TextKrKey(
      "ㄱ",
    ),
    TextKrKey(
      "ㅅ",
    ),
    TextKrKey(
      "ㅛ",
    ),
    TextKrKey(
      "ㅕ",
    ),
    TextKrKey(
      "ㅑ",
    ),
    TextKrKey(
      "ㅐ",
    ),
    TextKrKey(
      "ㅔ",
    ),
  ],
  // Row 2
  [
    TextKrKey(
      "ㅁ",
    ),
    TextKrKey(
      "ㄴ",
    ),
    TextKrKey(
      "ㅇ",
    ),
    TextKrKey(
      "ㄹ",
    ),
    TextKrKey(
      "ㅎ",
    ),
    TextKrKey(
      "ㅗ",
    ),
    TextKrKey(
      "ㅓ",
    ),
    TextKrKey(
      "ㅏ",
    ),
    TextKrKey(
      "ㅣ",
    ),
  ],
  // Row 3
  [
    ActionKey(VirtualKeyboardKeyAction.Shift),
    TextKrKey(
      "ㅋ",
    ),
    TextKrKey(
      "ㅌ",
    ),
    TextKrKey(
      "ㅊ",
    ),
    TextKrKey(
      "ㅍ",
    ),
    TextKrKey(
      "ㅠ",
    ),
    TextKrKey(
      "ㅜ",
    ),
    TextKrKey(
      "ㅡ",
    ),
    ActionKey(VirtualKeyboardKeyAction.Backspace),
  ],
  // Row 4
  [
    ActionKey(VirtualKeyboardKeyAction.Symbols),
    TextKrKey(','),
    ActionKey(VirtualKeyboardKeyAction.Space),
    TextKrKey('.'),
    ActionKey(VirtualKeyboardKeyAction.local),
  ]
];

/// 특수문자 및 숫자 키보드
List<List<VirtualKeyboardKey>> symbolLayout = [
  // Row 1
  [
    TextUsKey(
      "1",
    ),
    TextUsKey(
      "2",
    ),
    TextUsKey(
      "3",
    ),
    TextUsKey(
      "4",
    ),
    TextUsKey(
      "5",
    ),
    TextUsKey(
      "6",
    ),
    TextUsKey(
      "7",
    ),
    TextUsKey(
      "8",
    ),
    TextUsKey(
      "9",
    ),
    TextUsKey(
      "0",
    ),
  ],
  // Row 2
  [
    TextUsKey('@'),
    TextUsKey('#'),
    TextUsKey('\$'),
    TextUsKey('_'),
    TextUsKey('-'),
    TextUsKey('+'),
    TextUsKey('('),
    TextUsKey(')'),
    TextUsKey('/'),
  ],
  // Row 3
  [
    TextUsKey('|'),
    TextUsKey('*'),
    TextUsKey('"'),
    TextUsKey('\''),
    TextUsKey(':'),
    TextUsKey(';'),
    TextUsKey('!'),
    TextUsKey('?'),
    ActionKey(VirtualKeyboardKeyAction.Backspace),
  ],
  // Row 5
  [
    ActionKey(VirtualKeyboardKeyAction.Alpha),
    TextUsKey(','),
    ActionKey(VirtualKeyboardKeyAction.Space),
    TextUsKey('.'),
    ActionKey(VirtualKeyboardKeyAction.local),
  ]
];

/// 숫자만 있는 키보드
List<List<VirtualKeyboardKey>> numericLayout = [
  // Row 1
  [
    TextUsKey('1'),
    TextUsKey('2'),
    TextUsKey('3'),
  ],
  // Row 1
  [
    TextUsKey('4'),
    TextUsKey('5'),
    TextUsKey('6'),
  ],
  // Row 1
  [
    TextUsKey('7'),
    TextUsKey('8'),
    TextUsKey('9'),
  ],
  // Row 1
  [
    TextUsKey('.'),
    TextUsKey('0'),
    ActionKey(VirtualKeyboardKeyAction.Backspace)
  ],
];
