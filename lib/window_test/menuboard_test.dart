import 'dart:async';

import 'package:flutter/material.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

class MenuBoardTest extends StatefulWidget {
  const MenuBoardTest({super.key});

  @override
  State<MenuBoardTest> createState() => _MenuBoardTestState();
}

class _MenuBoardTestState extends State<MenuBoardTest> {
  Timer? _monitorCheckTimer;
  int _lastDisplayCount = 0;

  @override
  void initState() {
    super.initState();
    // setFullScreenMode();
    startMonitorConnectionWatcher(); // 모니터 연결 감지 시작
  }

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

  // Future<void> setFullScreenMode() async {
  //   await windowManager.setFullScreen(true);
  // }

  Future<void> initDeviceSizeFromCurrentScreen() async {
    await windowManager.ensureInitialized();
    List<Display> displays = await screenRetriever.getAllDisplays();

    double totalWidth = 0;
    double maxHeight = 0;

    // 첫 번째 디스플레이 기준으로 시작 좌표 설정
    Offset startPosition = displays.first.visiblePosition ?? Offset.zero;

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

    // await windowManager.setPosition(startPosition);
    await windowManager.setPosition(const Offset(0, 0));

    WindowOptions windowOptions = WindowOptions(
      size: Size(totalWidth, maxHeight),
      minimumSize: Size(totalWidth, maxHeight),
      maximumSize: Size(totalWidth, maxHeight),
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setFullScreen(false);
      await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
      await windowManager.setAsFrameless();
      await windowManager.show();
      await windowManager.focus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FittedBox(
        child: SizedBox(
          width: 3840,
          height: 1080,
          child: _buildSingleSplitPage(),
        ),
      ),
    );
  }

  Widget _buildSingleSplitPage() {
    return FittedBox(
      child: SizedBox(
        width: 3840,
        height: 1080,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 1920,
              height: 1080,
              //좌측 화면
              child: Container(
                color: Colors.blue,
              ),
            ),
            // 우측 화면
            SizedBox(
              width: 1920,
              height: 1080,
              child: Container(
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
