import 'package:flutter/material.dart';

class OpacityScreen extends StatefulWidget {
  const OpacityScreen({super.key});

  @override
  State<OpacityScreen> createState() => _OpacityScreenState();
}

class _OpacityScreenState extends State<OpacityScreen> {
  var opacityValue = 1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('AnimatiedOpaicty'),
        AnimatedOpacity(
          opacity: opacityValue,
          duration: Duration(seconds: 1),
          child: FlutterLogo(
            size: 100,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  opacityValue = 1.0;
                });
              },
              child: Text('Fade in'),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  opacityValue = 0.0;
                });
              },
              child: Text('Fade out'),
            ),
          ],
        )
      ],
    );
  }
}
