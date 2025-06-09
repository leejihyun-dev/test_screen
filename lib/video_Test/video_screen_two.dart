import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player_win/video_player_win.dart';

class VideoTestScreen extends StatefulWidget {
  final String url;
  const VideoTestScreen({
    super.key,
    required this.url,
  });

  @override
  State<VideoTestScreen> createState() => _VideoTestScreenState();
}

class _VideoTestScreenState extends State<VideoTestScreen> {
  WinVideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    reload();
  }

  void reload() {
    controller?.dispose();
    controller = WinVideoPlayerController.file(File(widget.url
        // "C:\\SQISoft\\eliga-player-v2\\data\\contents\\17338177143858b8c8.mp4"
        ));
    controller!.initialize().then((value) {
      if (controller!.value.isInitialized) {
        controller!.play();
        controller!.setLooping(true);
        setState(() {}); // 비디오 초기화가 완료되면 UI 업데이트
      } else {
        print("video file load failed");
      }
    }).catchError((e) {
      print("controller.initialize() error occurs: $e");
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: controller != null && controller!.value.isInitialized
            ? WinVideoPlayer(controller!)
            : Center(child: CircularProgressIndicator()), // 초기화 대기 중일 때 로딩 표시
      ),
    );
  }
}
