import 'package:flutter/material.dart';
import 'package:test_screen_change/window_test/content_page.dart';

// 픽업보드 or 메뉴보드 content 화면
class WindowScreenLayoutPage extends StatelessWidget {
  final String testUrl;

  const WindowScreenLayoutPage({
    super.key,
    required this.testUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ContentPage(
      testUrl: testUrl,
    );
  }
}
