import 'package:flutter/material.dart';

class ContainerScreen extends StatefulWidget {
  const ContainerScreen({super.key});

  @override
  State<ContainerScreen> createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  bool _trigger = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('animation container'),
        Container(
          color: Colors.blue.shade200,
          padding: EdgeInsets.zero,
          child: AnimatedContainer(
            width: _trigger ? 200.0 : 100.0,
            height: _trigger ? 100.0 : 200.0,
            child: FlutterLogo(size: 50),
            alignment: _trigger ? Alignment.topCenter : Alignment.bottomCenter,
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
