import 'package:flutter/material.dart';

class PaddingScreen extends StatefulWidget {
  const PaddingScreen({super.key});

  @override
  State<PaddingScreen> createState() => _PaddingScreenState();
}

class _PaddingScreenState extends State<PaddingScreen> {
  bool _trigger = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('animation padding'),
        Container(
          width: 100.0,
          height: 100.0,
          color: Colors.red,
          child: AnimatedPadding(
            child: Container(
              color: Colors.black,
            ),
            padding: _trigger
                ? EdgeInsets.all(5.0)
                : EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
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
