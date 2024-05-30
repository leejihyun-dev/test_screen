import 'package:flutter/material.dart';

class AnimationControllerScreen extends StatefulWidget {
  const AnimationControllerScreen({super.key});

  @override
  State<AnimationControllerScreen> createState() =>
      _AnimationControllerScreenState();
}

class _AnimationControllerScreenState extends State<AnimationControllerScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('animation controller ${_animation.value.toStringAsFixed(2)}'),
        Container(
          width: _animation.value * 100,
          height: _animation.value * 100,
          child: FlutterLogo(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () {
                _controller.forward();
              },
              child: Text('forward'),
            ),
            FloatingActionButton(
              onPressed: () {
                _controller.stop();
              },
              child: Text('stop'),
            ),
            FloatingActionButton(
              onPressed: () {
                _controller.reverse();
              },
              child: Text('reverse'),
            ),
          ],
        )
      ],
    );
  }
}
