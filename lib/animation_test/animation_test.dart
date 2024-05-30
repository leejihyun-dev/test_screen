import 'package:flutter/material.dart';
import 'package:test_screen_change/animation_test/animations/animated_align.dart';
import 'package:test_screen_change/animation_test/animations/animated_container.dart';
import 'package:test_screen_change/animation_test/animations/animated_padding.dart';
import 'package:test_screen_change/animation_test/animations/animated_text.dart';
import 'package:test_screen_change/animation_test/animations/animation_contorller.dart';
import 'package:test_screen_change/animation_test/animations/animated_opacity.dart';

class AnimationTest extends StatefulWidget {
  const AnimationTest({super.key});

  @override
  State<AnimationTest> createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OpacityScreen(),
                AnimationControllerScreen(),
                AlignScreen(),
              ],
            ),
            Column(
              children: [
                ContainerScreen(),
                TextScreen(),
                PaddingScreen(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
