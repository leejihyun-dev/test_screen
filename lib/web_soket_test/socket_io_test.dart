import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:speech_balloon/speech_balloon.dart';

class SocketIoScreen extends StatefulWidget {
  const SocketIoScreen({super.key});

  @override
  State<SocketIoScreen> createState() => _SocketIoScreenState();
}

class _SocketIoScreenState extends State<SocketIoScreen> {
  final IO.Socket socket = IO.io('http://localhost:3000',
      IO.OptionBuilder().setTransports(['websocket']).build());

  List<String> receiveMessages = [];
  List<String> sendMessages = [];
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    sokectEventSetting();
  }

  void sokectEventSetting() {
    socket.onConnect((_) {
      //서버연결 확인
      print('Connected to server');
    });
    socket.onDisconnect((_) {
      //서버 끊겼을 때 재연결 시도
      print('Disconnected from server');
      _reconnect();
    });
    socket.onError((error) {
      print('Error: $error');
      // 에러를 감지하고 그에 따라 핸들링을 추가합니다.
    });

    socket.connect();
    socket.on('chat message', (data) {
      print('Received message: $data');
      // 메세지를 감지하고 UI에 표시하거나 처리합니다.f
      // if (data.containsKey('message') &&
      //     (data['user'] == 'test2')) {
      //   //상대방(test2)이 보낸 거만 저장하려구
      //   setState(() {
      //     receiveMessages.add(data['message']);
      //   });
      // }
    });
  }

  void sendMessage(String message) {
    print('send? $message');
    // socket.emit('chat message', message);

    socket.emit('chat message', {'user': 'test1', 'message': message});
    // setState(() {
    //   sendMessages.add(message);
    // });
    // 메시지를 서버로 보내는 코드입니다.
  }

  void _reconnect() {
    //연결이 끊겼을 때 다시 연결을 시도한다.
    Future.delayed(Duration(seconds: 5), () {
      print('Reconnecting...');
      socket.connect();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              sendMessage('Yellow');
            },
            child: Container(
              width: 150,
              height: 150,
              color: Colors.amber,
            ),
          ),
          GestureDetector(
            onTap: () {
              sendMessage('Pink');
            },
            child: Container(
              width: 150,
              height: 150,
              color: Colors.pink,
            ),
          ),
          GestureDetector(
            onTap: () {
              sendMessage('Blue');
            },
            child: Container(
              width: 150,
              height: 150,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
    // return Column( //채팅 Ui
    //   children: [
    //     Expanded(
    //       child: Container(
    //         color: Colors.amber,
    //         child: Padding(
    //           padding: EdgeInsets.only(bottom: 10),
    //           child: Row(
    //             children: [
    //               Container(
    //                 width: 200,
    //                 child: ListView.builder(
    //                   // reverse: true,
    //                   itemCount: receiveMessages.length,
    //                   itemBuilder: (context, index) {
    //                     return Column(
    //                       children: [
    //                         SpeechBalloon(
    //                           width: 150,
    //                           nipLocation: NipLocation.left,
    //                           color: Colors.grey,
    //                           borderRadius: 15,
    //                           child: Padding(
    //                             padding: EdgeInsets.only(
    //                               top: 10,
    //                               left: 10,
    //                               right: 10,
    //                               bottom: 10,
    //                             ),
    //                             child: Text(
    //                               receiveMessages[index],
    //                               style: TextStyle(fontSize: 18),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     );
    //                   },
    //                 ),
    //               ),
    //               Expanded(
    //                 child: ListView.builder(
    //                   // reverse: true,
    //                   itemCount: sendMessages.length,
    //                   itemBuilder: (context, index) {
    //                     return Padding(
    //                       padding: EdgeInsets.only(top: 0 == index ? 20 : 0),
    //                       child: Column(
    //                         children: [
    //                           SpeechBalloon(
    //                             width: 150,
    //                             nipLocation: NipLocation.right,
    //                             color: Colors.green,
    //                             borderRadius: 15,
    //                             child: Padding(
    //                               padding: EdgeInsets.only(
    //                                 top: 10,
    //                                 left: 10,
    //                                 right: 10,
    //                                 bottom: 10,
    //                               ),
    //                               child: Text(
    //                                 sendMessages[index],
    //                                 style: TextStyle(fontSize: 18),
    //                               ),
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 20,
    //                           )
    //                         ],
    //                       ),
    //                     );
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //     Container(
    //       decoration: BoxDecoration(
    //           border: Border(top: BorderSide(color: Colors.black54, width: 2))),
    //       child: Padding(
    //         padding: EdgeInsets.all(8),
    //         child: TextField(
    //           controller: _controller,
    //           autofocus: true,
    //           onSubmitted: (message) {
    //             sendMessage(message);
    //           },
    //           decoration: InputDecoration(labelText: 'Enter your message'),
    //         ),
    //       ),
    //     )
    //   ],
    // );
  }
}
