import 'package:flutter/material.dart';
import 'package:test_screen_change/package/vk/vk.dart';

class KeyboardServiceTest extends StatefulWidget {
  KeyboardServiceTest({Key? key}) : super(key: key);

  @override
  _KeyboardServiceTestState createState() => _KeyboardServiceTestState();
}

class _KeyboardServiceTestState extends State<KeyboardServiceTest> {
  // Holds the text that user typed.
  String text = '';

  // True if shift enabled.
  bool shiftEnabled = false;

  // is true will show the numeric keyboard.
  bool isNumericMode = false;

  late TextEditingController _controllerText;

  @override
  void initState() {
    super.initState();
    // if (widget.textEditingController != null) {
    //   input = HangulInput(widget.textEditingController!.text);
    // } else {

    // }
    _controllerText = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    /*
      final input = HangulInput('')
      input.pushCharacter('ㅎ')
      input.pushCharacter('ㅏ')
      print(input.text) <- 이런식으로 합치는거 같은데
    */

    return Scaffold(
      appBar: AppBar(
        title: Text('키보드'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: _controllerText,
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your text',
                  ),
                )),
            SwitchListTile(
              title: Text(
                'Keyboard Type = ' +
                    (isNumericMode
                        ? 'VirtualKeyboardType.Numeric'
                        : 'VirtualKeyboardType.Alphanumeric'),
              ),
              value: isNumericMode,
              onChanged: (val) {
                setState(() {
                  isNumericMode = val;
                });
              },
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              color: Colors.grey.shade900,
              child: VirtualKeyboard(
                height: 400,
                type: isNumericMode
                    ? VirtualKeyboardType.Numeric
                    : VirtualKeyboardType.Basic,
                textController: _controllerText,
              ),
            )
          ],
        ),
      ),
    );
  }
}
