import 'package:flutter/material.dart';

class AlignScreen extends StatefulWidget {
  const AlignScreen({super.key});

  @override
  State<AlignScreen> createState() => _AlignScreenState();
}

class _AlignScreenState extends State<AlignScreen> {
  AlignmentGeometry _alignment = Alignment.bottomLeft;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('animation align'),
        Container(
          width: 200,
          height: 200,
          color: Colors.blue.shade200,
          padding: EdgeInsets.zero,
          child: AnimatedAlign(
            child: FlutterLogo(size: 100),
            alignment: _alignment,
            duration: Duration(seconds: 1),
            curve: Curves.easeIn,
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            setState(() {
              _alignment = (_alignment == Alignment.bottomLeft)
                  ? Alignment.topRight
                  : Alignment.bottomLeft;
            });
          },
          child: Text('start'),
        )
      ],
    );
  }
}
