import 'package:flutter/material.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  bool _trigger = false;
  TextStyle textStyle() {
    return _trigger
        ? TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          )
        : TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('animation text'),
        Container(
          padding: EdgeInsets.zero,
          child: AnimatedDefaultTextStyle(
            child: Text("Default Text Style"),
            style: textStyle(),
            duration: Duration(seconds: 1),
            curve: Curves.easeIn,
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            setState(() {
              _trigger = !_trigger;
            });
          },
          child: Text('start'),
        )
      ],
    );
  }
}
