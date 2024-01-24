import 'package:flutter/material.dart';
import 'package:test_screen_change/component/common_trasition.dart';

class VideoScreen extends StatefulWidget {
  final String option;
  const VideoScreen({super.key, required this.option});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward(); //이게 있어야 fade제대로 댐
  }

  @override
  Widget build(BuildContext context) {
    return transitionWidget();
  }

  Widget transitionWidget() {
    switch (widget.option) {
      case "changeOpacity":
        print('### _animation $_animation');
        return FadeTransition(
          //나타나기
          opacity: _animation,
          child: Container(
            color: Colors.blue,
          ),
        );
      case "leftToRight":
        return SlideTransition(
          //왼쪽에서 오른쪽으로
          position: _animation.drive(
              Tween<Offset>(begin: const Offset(-1.0, 0), end: Offset.zero)),
          child: Container(color: Colors.blue),
        );
      case "rightToLeft":
        return SlideTransition(
          //오른쪽에서 왼쪽으로
          position: _animation.drive(
              Tween<Offset>(begin: const Offset(1.0, 0), end: Offset.zero)),
          child: Container(color: Colors.blue),
        );
      case "bottomToTop":
        return SlideTransition(
          //아래에서 위로 슬라이드
          position: _animation.drive(
              Tween<Offset>(begin: const Offset(0, 1.0), end: Offset.zero)),
          child: Container(color: Colors.blue),
        );
      case "topToBottom":
        return SlideTransition(
          //위에서 아래로
          position: _animation.drive(
              Tween<Offset>(begin: const Offset(0, -1.0), end: Offset.zero)),
          child: Container(color: Colors.blue),
        );
      default:
        return Container(
          color: Colors.blue,
        );
    }
  }
}
