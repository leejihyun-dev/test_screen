import 'package:flutter/material.dart';

class GradientTestScreen extends StatefulWidget {
  const GradientTestScreen({super.key});

  @override
  State<GradientTestScreen> createState() => _GradientTestScreenState();
}

class _GradientTestScreenState extends State<GradientTestScreen> {
  late AnimationController _controller;
  late Animation<Gradient?> _animation;

  @override
  void initState() {
    super.initState();

    // _controller = AnimationController(
    //   duration: Duration(seconds: 2),
    //   vsync: this,
    // );

    _animation = LinearGradientTween(
      begin: LinearGradient(colors: [Colors.blue, Colors.purple]),
      end: LinearGradient(colors: [Colors.purple, Colors.blue]),
    ).animate(_controller);

    _controller.repeat(reverse: true); // Repeat the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                gradient: _animation.value,
              ),
              // Your other widgets can go here,
              // e.g., Text('Hello, Flutter!'),
            );
          },
        ),
      ),
    );
  }
}

class LinearGradientTween extends Tween<Gradient?> {
  LinearGradientTween({Gradient? begin, Gradient? end})
      : super(begin: begin, end: end);

  @override
  Gradient? lerp(double t) {
    return LinearGradient.lerp(
        begin as LinearGradient?, end as LinearGradient?, t);
  }
}
