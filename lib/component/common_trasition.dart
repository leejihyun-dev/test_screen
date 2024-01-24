import 'package:flutter/material.dart';

class CommonTrasition extends StatefulWidget {
  const CommonTrasition({super.key});

  @override
  State<CommonTrasition> createState() => _CommonTrasitionState();
}

class _CommonTrasitionState extends State<CommonTrasition>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        color: Colors.blue,
      ),
    );
  }
}
