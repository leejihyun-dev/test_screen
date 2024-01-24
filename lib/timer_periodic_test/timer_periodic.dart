import 'dart:async';

import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  PageController pageController = PageController(initialPage: 0);
  List<Color> testColor = [
    Colors.orange,
    Colors.blue,
    Colors.yellow,
    Colors.pink
  ];

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      int curPage = pageController.page!.toInt();
      int nextPage = curPage + 1;

      if (nextPage == testColor.length) {
        nextPage = 0;
      }

      pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.linear,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: testColor.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: testColor[index],
          );
        },
      ),
    );
  }
}
