import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class StompClientTest extends StatefulWidget {
  const StompClientTest({super.key});

  @override
  State<StompClientTest> createState() => _StompClientTestState();
}

// 채팅 목록을 저장할 리스트
List<Msg> messages = [];
int chatRoomId = 1;

class _StompClientTestState extends State<StompClientTest> {
  late StompClient stompClient;

  void onConnect(StompClient stompClient, StompFrame frame) {
    stompClient.subscribe(
      destination: '/topic/1',
      callback: (frame) {
        //List<dynamic>? result = json.decode(frame.body!);
        Map<String, dynamic> obj = json.decode(frame.body!);
        Msg message = Msg(
            detailMessage: obj['detailMessage'],
            roomId: obj['roomId'],
            senderId: obj['senderId'],
            senderName: obj['senderName'],
            type: obj['type']);
        setState(() => {
              messages.add(message),
            });
      },
    );
  }

  @override
  void initState() {
    super.initState();

    stompClient = StompClient(
      config: StompConfig(
          url: 'ws://localhost:8080/ws/chat',
          onConnect: (frame) => onConnect(stompClient, frame),
          beforeConnect: () async {
            print('waiting to connect...');
            await Future.delayed(const Duration(milliseconds: 200));
            print('connecting...');
          },
          onWebSocketError: (dynamic error) => print(error.toString())
          //stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
          //webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
          ),
    );

    stompClient.activate();
  }

  @override
  void dispose() {
    super.dispose();
    // 웹소켓에서 연결 해제
    stompClient.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Msg {
  String type;
  int roomId;
  int senderId;
  String detailMessage;
  String senderName;

  Msg(
      {required this.type,
      required this.roomId,
      required this.senderId,
      required this.detailMessage,
      required this.senderName});
}
