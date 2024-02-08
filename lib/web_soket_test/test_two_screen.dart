import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_screen_change/web_soket_test/web_soket_test.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TestTwoScreen extends StatefulWidget {
  const TestTwoScreen({super.key});

  @override
  State<TestTwoScreen> createState() => _TestTwoScreenState();
}

class _TestTwoScreenState extends State<TestTwoScreen> {
  late final WebSocketChannel _channel;

  @override
  void initState() {
    super.initState();
    // connectChannel();
  }

  void connectChannel() {
    _channel = WebSocketChannel.connect(Uri.parse(
        'ws://localhost:8080/ws/chat')); // 웹소켓 서버 정보 wss://echo.websocket.events
    final msg = {
      "type": "ENTER",
      "roomId": "1",
      "name": "이지현???",
    };
    _channel.sink.add(jsonEncode(msg));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.yellow.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '컨트롤러',
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => WebSoketScreen(),
                  ),
                );
              },
              child: Text('컨트롤화면 가기'),
            )
          ],
        ),
        // child: StreamBuilder(
        //     stream: _channel.stream,
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         return Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Center(
        //               child: Text(
        //                 '컨트롤러',
        //                 style: TextStyle(fontSize: 30),
        //               ),
        //             ),
        //             SizedBox(
        //               height: 30,
        //             ),
        //             ElevatedButton(
        //               onPressed: () {
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute<void>(
        //                     builder: (BuildContext context) => WebSoketScreen(),
        //                   ),
        //                 );
        //               },
        //               child: Text('컨트롤화면 가기'),
        //             )
        //           ],
        //         );
        //       } else {
        //         return Center(
        //           child: Text('연결 실패!'),
        //         );
        //       }
        //     }),
      ),
    );
  }
}
