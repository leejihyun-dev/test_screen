import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

//클라이언트1
class WebSoketScreen extends StatefulWidget {
  const WebSoketScreen({super.key});

  @override
  State<WebSoketScreen> createState() => _WebSoketScreenState();
}

class _WebSoketScreenState extends State<WebSoketScreen> {
  late final WebSocketChannel _channel;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    connectChannel();
  }

  void connectChannel() {
    //서버 연결 시도
    _channel = WebSocketChannel.connect(Uri.parse(
        'ws://localhost:8080/ws/chat')); // 웹소켓 서버 정보 wss://echo.websocket.events
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _channel.sink.close(); //소켓 서버 연결 끊기
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: _controller,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        StreamBuilder(
            stream: _channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('snapshot.data ${snapshot.data}');
                return Text(snapshot.data);
              } else {
                return Container();
              }
            }),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            FloatingActionButton(
              //눈꽃버튼
              //연결 입장
              onPressed: () {
                final msg = {
                  "type": "ENTER",
                  "roomId": "1",
                  "name": "이지현???",
                };
                _channel.sink.add(jsonEncode(msg));
              },
              child: Icon(Icons.ac_unit_rounded),
            ),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              //보내기
              onPressed: () {
                final talkMsg = {
                  "type": "TALK",
                  "roomId": "1",
                  "sender": "chee",
                  "msg": _controller.text.toString(),
                };
                _channel.sink.add(jsonEncode(talkMsg));
              },
              child: Icon(Icons.send),
            ),
          ],
        ),
      ],
    );
  }
}
