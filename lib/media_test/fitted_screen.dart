import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_screen_change/media_test/image_screen.dart';
import 'package:test_screen_change/media_test/video_screen.dart';

class FittedScreen extends StatefulWidget {
  const FittedScreen({super.key});

  @override
  State<FittedScreen> createState() => _FittedScreenState();
}

class _FittedScreenState extends State<FittedScreen> {
  int index = 0;
  String? typeTest;

  @override
  void initState() {
    print('start');
    Timer.periodic(Duration(seconds: 4), (timer) {
      for (int i = index; i < 5; i++) {
        print('index $index');
      }
      index++;
      if (index == 4) {
        index = 0;
      }
      setState(() {}); //timer안에 넣어야 index 값이 달라짐에 따라 화면이 변한다.
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (index % 2 == 0)
          ? AnimatedSwitcher(
              duration: const Duration(seconds: 2),
              child: VideoScreen(
                key: UniqueKey(), // 음
                option: 'changeOpacity',
              ),
            )
          : ImageScreen(
              key: UniqueKey(),
            ),
    );
  }
}
