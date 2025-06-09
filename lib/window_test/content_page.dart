import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_screen_change/video_Test/video_screen_two.dart';

class ContentPage extends ConsumerStatefulWidget {
  final String testUrl;

  const ContentPage({
    super.key,
    required this.testUrl,
  });

  @override
  ConsumerState<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends ConsumerState<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1920,
      height: 1080,
      child: ClipPath(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            widget.testUrl,
          ),
        ),
      ),
    );
  }
}
