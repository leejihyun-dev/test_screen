import 'dart:async';

import 'package:flutter/material.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:test_screen_change/window_test/window_screen_layout_page.dart';
import 'package:window_manager/window_manager.dart';

class WindowTestScreen extends StatefulWidget {
  const WindowTestScreen({super.key});

  @override
  State<WindowTestScreen> createState() => _WindowTestScreenState();
}

class _WindowTestScreenState extends State<WindowTestScreen> {
  List<String> testUrl = [
    'assets/test_data/test_image01.jpg',
    'assets/test_data/test_image_02.jpg',
    'assets/test_data/test_image03.jpg'
  ];
  double widthTest = 0.0;
  double heightTest = 0.0;

  @override
  void initState() {
    super.initState();
    // _setFullScreenMode();
    startMonitorConnectionWatcher(); // 모니터 연결 감지 시작
  }

  int _lastDisplayCount = 0;
  Timer? _monitorCheckTimer;

  void startMonitorConnectionWatcher() {
    //모니터 연결 감지 시작
    _monitorCheckTimer?.cancel(); // 기존 타이머 정리

    _monitorCheckTimer = Timer.periodic(Duration(seconds: 3), (timer) async {
      List<Display> displays = await screenRetriever.getAllDisplays();
      int currentCount = displays.length;

      if (currentCount != _lastDisplayCount) {
        print('🔌 모니터 연결 상태 변경 감지! ($currentCount → $_lastDisplayCount)');
        _lastDisplayCount = currentCount;

        // 디스플레이 설정 다시 초기화
        await initDeviceSizeFromCurrentScreen();
      }
    });
  }

  Future<void> initDeviceSize(double width, double height) async {
    await windowManager.ensureInitialized();

    await windowManager.setPosition(const Offset(0, 0));

    WindowOptions windowOptions = WindowOptions(
      size: Size(width, height),
      minimumSize: Size(width, height),
      maximumSize: Size(width, height),
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setFullScreen(false);
      await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
      await windowManager.setAsFrameless(); // 추가 테두리 제거
      await windowManager.show();
      await windowManager.focus();
    });
  }

  Future<void> initDeviceSizeFromCurrentScreen() async {
    await windowManager.ensureInitialized();
    List<Display> displays = await screenRetriever.getAllDisplays();

    double totalWidth = 0;
    double maxHeight = 0;

    // 첫 번째 디스플레이 기준으로 시작 좌표 설정
    displays
        .sort((a, b) => a.visiblePosition!.dx.compareTo(b.visiblePosition!.dx));

    final Offset startPosition = displays.first.visiblePosition ?? Offset.zero;

    for (int i = 0; i < displays.length; i++) {
      final display = displays[i];

      final physicalWidth = display.size.width * display.scaleFactor!;
      final physicalHeight = display.size.height * display.scaleFactor!;

      totalWidth += physicalWidth; //display.size.width;
      if (physicalHeight > maxHeight) {
        //display.size.height
        maxHeight = physicalHeight; //display.size.height;
      }

      print('모니터 $i:');
      print(
          ' - 위치: (${display.visiblePosition!.dx}, ${display.visiblePosition!.dy})');

      print(' - 논리 해상도: ${display.size.width} x ${display.size.height}');
      print(' - 물리 해상도: $physicalWidth x $physicalHeight');

      print(' - DPI: ${display.scaleFactor}');
      print('------------------------');
    }
    print('합산 width: $totalWidth height: $maxHeight');
    print('시작 위치: (${startPosition.dx}, ${startPosition.dy})');

    await windowManager.setPosition(startPosition);
    // await windowManager.setPosition(const Offset(0, 0));

    // WindowOptions windowOptions = WindowOptions(
    //   size: Size(totalWidth, maxHeight),
    //   minimumSize: Size(totalWidth, maxHeight),
    //   maximumSize: Size(totalWidth, maxHeight),
    //   backgroundColor: Colors.transparent,
    //   skipTaskbar: false,
    // );

    // windowManager.waitUntilReadyToShow(windowOptions, () async {
    //   await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    //   await windowManager.setAsFrameless();
    //   await windowManager.show();
    //   await windowManager.focus();
    // });
  }

  List<Widget> getMonitorCount() {
    double width = 1080;
    double height = 1920;

    width = 5760;
    // displayOptionType == DisplayOptionType.VERTICAL_2160
    // ? 2160
    // : 3840; TODO 3840 보다 더 크게 줄때 먹힘s
    height = 1080;
    // displayOptionType == DisplayOptionType.VERTICAL_2160 ? 1920 : 1080;

    initDeviceSize(width, height);
    initDeviceSizeFromCurrentScreen();

    return List.generate(testUrl.length, (index) {
      final frame = testUrl[index];

      return WindowScreenLayoutPage(
        testUrl: frame,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: getMonitorCount().map((frameWidget) {
          return Expanded(
            child: frameWidget,
          );
        }).toList(),
      ),
    );
  }
}
