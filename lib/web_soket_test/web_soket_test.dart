import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

//클라이언트1
class WebSoketScreen extends StatefulWidget {
  const WebSoketScreen({super.key});

  @override
  State<WebSoketScreen> createState() => _WebSoketScreenState();
}

class _WebSoketScreenState extends State<WebSoketScreen>
    with SingleTickerProviderStateMixin {
  late final WebSocketChannel _channel;
  late final TextEditingController _controller;

  String totalLength = '00:00';
  String currentLength = '00:00';
  int intTotal = 1; //스크롤바가 맨처음 영상이랑 연결되기 전에 오류 안나려면 0/1 사이에 있어야하길래 수정
  // int intCur = 0;
  Duration _totalDuration =
      Duration(hours: 0, minutes: 0, seconds: 0, milliseconds: 0);

  // Duration _duration = Duration.zero;
  double _duration = 0.0;
  Duration _position = Duration.zero;

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
    final msg = {
      "type": "ENTER",
      "roomId": "1",
      "name": "이지현???",
    };
    _channel.sink.add(jsonEncode(msg));
    // _channel = WebSocketChannel.connect(
    //     Uri.parse('ws://192.168.102.56:8080/my-websocket'));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _channel.sink.close(); //소켓 서버 연결 끊기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.pink.shade200,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'stop',
                  //멈춤버튼
                  onPressed: () {
                    final talkMsg = {
                      "type": "TALK",
                      "roomId": "1",
                      "sender": "chee",
                      "msg": 'stop', //
                      "length": "",
                      "playLength": "",
                    };
                    _channel.sink.add(jsonEncode(talkMsg));
                  },
                  child: Icon(Icons.stop),
                ),
                FloatingActionButton(
                  heroTag: 'replay',
                  //다시 재생
                  onPressed: () {
                    final talkMsg = {
                      "type": "TALK",
                      "roomId": "1",
                      "sender": "chee",
                      "msg": 'play',
                      "length": "",
                      "playLength": "",
                    };
                    _channel.sink.add(jsonEncode(talkMsg));
                  },
                  child: Icon(Icons.play_arrow),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              //볼륨
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'volumnon',
                  onPressed: () {
                    final talkMsg = {
                      "type": "TALK",
                      "roomId": "1",
                      "sender": "chee",
                      "msg": 'volumnOn',
                      "length": "",
                      "playLength": "",
                    };
                    _channel.sink.add(jsonEncode(talkMsg));
                  },
                  child: Icon(Icons.volume_up_rounded),
                ),
                FloatingActionButton(
                  heroTag: 'volumnmute',
                  onPressed: () {
                    final talkMsg = {
                      "type": "TALK",
                      "roomId": "1",
                      "sender": "chee",
                      "msg": 'volumnMute',
                      "length": "",
                      "playLength": "",
                    };
                    _channel.sink.add(jsonEncode(talkMsg));
                  },
                  child: Icon(Icons.volume_off_rounded),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'left',
                  //영상 돌리기
                  onPressed: () {
                    final talkMsg = {
                      "type": "TALK",
                      "roomId": "1",
                      "sender": "chee",
                      "msg": 'left',
                      "length": "",
                      "playLength": "",
                    };
                    _channel.sink.add(jsonEncode(talkMsg));
                  },
                  child: Icon(Icons.keyboard_double_arrow_left_outlined),
                ),
                FloatingActionButton(
                  heroTag: 'right',
                  //영상 넘기기
                  onPressed: () {
                    final talkMsg = {
                      "type": "TALK",
                      "roomId": "1",
                      "sender": "chee",
                      "msg": 'right',
                      "length": "",
                      "playLength": "",
                    };
                    _channel.sink.add(jsonEncode(talkMsg));
                  },
                  child: Icon(Icons.keyboard_double_arrow_right_outlined),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            StreamBuilder(
                stream: _channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> data =
                        json.decode(snapshot.data.toString());
                    if (data['sender'] == 'totalLength') {
                      totalLength = data['msg'];

                      // List<String> timeParts = data['playLength'].split(":");
                      // int hours = int.parse(timeParts[0]);
                      // int minutes = int.parse(timeParts[1]);
                      // List<String> secondsAndMilliseconds =
                      //     timeParts[2].split(".");
                      // int seconds = int.parse(secondsAndMilliseconds[0]);
                      // int milliseconds = int.parse(secondsAndMilliseconds[1]);
                      // print(
                      //     'dkdhtlqkf $timeParts $hours $minutes $secondsAndMilliseconds $seconds $milliseconds');

                      // _totalDuration = Duration(
                      //   hours: hours,
                      //   minutes: minutes,
                      //   seconds: seconds,
                      //   milliseconds: milliseconds,
                      // );

                      // intTotal = int.parse(data['length']);
                      // print('_totalDuration뭥미 $_totalDuration'); //값이 이상하게 찍혀;

                      _duration =
                          double.parse(data['playLength']); //_totalDuration;
                    }
                    if (data['sender'] == 'currentLength') {
                      List<String> timeParts = data['playLength'].split(":");
                      int hours = int.parse(timeParts[0]);
                      int minutes = int.parse(timeParts[1]);
                      List<String> secondsAndMilliseconds =
                          timeParts[2].split(".");
                      int seconds = int.parse(secondsAndMilliseconds[0]);
                      int milliseconds = int.parse(secondsAndMilliseconds[1]);

                      Duration _current = Duration(
                        hours: hours,
                        minutes: minutes,
                        seconds: seconds,
                        milliseconds: milliseconds,
                      );

                      currentLength = data['msg'];

                      _position = _current;
                      // intCur = int.parse(data['length']);
                    }

                    // int _intTotal =
                    //     _totalDuration.inSeconds; //클릭한 위치의 재생시간을 알아내기 위해 사용
                    // print(
                    //     'snapshot.connectionState 이게 뭐임 ${snapshot.connectionState}');
                    // if (snapshot.connectionState == ConnectionState.done) {
                    //   print('재연결 시도');
                    //   final msg = {
                    //     "type": "ENTER",
                    //     "roomId": "1",
                    //     "name": "이지현???",
                    //   };
                    //   _channel.sink.add(jsonEncode(msg));
                    // }

                    // return Padding(
                    //   padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                    //   child: Column(
                    //     children: [
                    //       Stack( //LinearProgressIndicator 버전 재생바
                    //         children: [
                    //           SizedBox(
                    //             width: MediaQuery.of(context).size.width,
                    //             height: 30,
                    //             child: GestureDetector(
                    //               onTapDown: (details) {
                    //                 // 전체 동영상 재생 시간을 초로 가정
                    //                 double totalDurationInSeconds =
                    //                     _intTotal.toDouble();
                    //                 // 선택한 위치를 전체 길이에 대한 백분율로 계산
                    //                 double selectedPercentage =
                    //                     details.localPosition.dx /
                    //                         MediaQuery.of(context).size.width;
                    //                 // 해당 백분율에 따른 시간을 초로 계산
                    //                 double selectedTimeInSeconds =
                    //                     selectedPercentage *
                    //                         totalDurationInSeconds;

                    //                 // 초를 분과 초로 변환
                    //                 int selectedMinutes =
                    //                     (selectedTimeInSeconds / 60).floor();
                    //                 int selectedSeconds =
                    //                     (selectedTimeInSeconds % 60).floor();

                    //                 // 분이 60분을 넘어가면 시간을 계산
                    //                 int selectedHours = 0;
                    //                 if (selectedMinutes >= 60) {
                    //                   selectedHours =
                    //                       (selectedMinutes / 60).floor();
                    //                   selectedMinutes %= 60;
                    //                 }

                    //                 print(
                    //                     '선택한 시간: $selectedHours:$selectedMinutes:$selectedSeconds');
                    //                 final talkMsg = {
                    //                   "type": "TALK",
                    //                   "roomId": "1",
                    //                   "sender": "videoControl",
                    //                   "msg":
                    //                       '$selectedHours:$selectedMinutes:$selectedSeconds',
                    //                   "length": "",
                    //                   "playLength": "",
                    //                 };
                    //                 _channel.sink.add(jsonEncode(talkMsg));
                    //               },
                    //               child: ClipRRect(
                    //                 borderRadius: const BorderRadius.all(
                    //                     Radius.circular(20)),
                    //                 child: LinearProgressIndicator(
                    //                   backgroundColor: Colors.yellow,
                    //                   color: Colors.blue,
                    //                   value: (intCur / intTotal),
                    //                   minHeight: 30,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           Align(
                    //             alignment: Alignment.lerp(
                    //               Alignment.topLeft,
                    //               Alignment.topRight,
                    //               (intCur / intTotal),
                    //             )!,
                    //             child: Container(
                    //               width: 30,
                    //               height: 30,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(50),
                    //                 color: Colors.red,
                    //               ),
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.only(left: 15),
                    //         child: Row(
                    //           children: [
                    //             Text('$currentLength / '),
                    //             Text('$totalLength'),
                    //           ],
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // );
                    return Padding(
                      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Column(
                        children: [
                          SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 20, //진행바 높이
                              activeTrackColor: Colors.blue.shade300, //채워지는 색
                              inactiveTrackColor: Color(0xFF757575), //진행바
                              thumbColor: Colors.amber, //진행버튼 색
                              thumbShape: //진행버튼 크기조절
                                  RoundSliderThumbShape(enabledThumbRadius: 20),
                              //
                              overlayColor: Color(0xFFCDDC39).withOpacity(0.2),
                              overlayShape: //버튼 눌렀을 때 퍼짐 효과
                                  RoundSliderOverlayShape(overlayRadius: 30),
                            ),
                            child: Slider(
                              min: 0,
                              max: _duration,
                              value: _position.inSeconds.toDouble(),
                              onChanged: (value) {
                                // final test = value.toInt();
                                // // Duration(seconds: value.toInt());
                                // print('onchanged $value $test');
                                // // player.seek(position);

                                // final talkMsg = {
                                //   "type": "TALK",
                                //   "roomId": "1",
                                //   "sender": "chee",
                                //   "msg": 'playProgressbar',
                                //   "length": "$test",
                                //   "playLength": "",
                                // };
                                // _channel.sink.add(jsonEncode(talkMsg));
                              },
                              onChangeEnd: (value) {
                                final test = value.toInt();
                                final talkMsg = {
                                  "type": "TALK",
                                  "roomId": "1",
                                  "sender": "chee",
                                  "msg": 'playProgressbar',
                                  "length": "$test",
                                  "playLength": "",
                                };
                                _channel.sink.add(jsonEncode(talkMsg));
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                Text('$currentLength / '),
                                Text('$totalLength'),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 200,
                            child: FloatingActionButton(
                              heroTag: 'reconnect',
                              //재연결 버튼
                              onPressed: () {
                                _channel.sink.close();
                                _channel = WebSocketChannel.connect(Uri.parse(
                                    'ws://localhost:8080/ws/chat')); // 웹소켓 서버 정보 wss://echo.websocket.events
                                final msg = {
                                  "type": "ENTER",
                                  "roomId": "1",
                                  "name": "이지현???",
                                };
                                _channel.sink.add(jsonEncode(msg));
                              },
                              child: Text('연결이 끊겼어요.!\n재연결하기'),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width,
                          //   height: 30,
                          //   child: ClipRRect(
                          //     borderRadius:
                          //         const BorderRadius.all(Radius.circular(20)),
                          //     child: LinearProgressIndicator(
                          //       backgroundColor: Colors.yellow,
                          //       color: Colors.blue,
                          //       // value: (intCur / intTotal),
                          //       minHeight: 30,
                          //     ),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 15),
                          //   child: Row(
                          //     children: [
                          //       Text('$currentLength / '),
                          //       Text('$totalLength'),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    );
                  }

                  // return Column(
                  //   children: [
                  //     AnimatedBuilder(
                  //         animation: _animationController,
                  //         builder: (_, __) {
                  //           return SliderTheme(
                  //             data: SliderTheme.of(context).copyWith(
                  //               trackHeight: 10,
                  //             ),
                  //             child: Slider(
                  //               value: _animationController.value,
                  //               // max: 100,
                  //               onChanged: null,
                  //             ),
                  //           );
                  //         }),
                  //     Padding(
                  //       padding: EdgeInsets.only(left: 15),
                  //       child: Row(
                  //         children: [
                  //           Text('$currentLength / '),
                  //           Text('$totalLength'),
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // );
                }),
          ],
        ),
      ),
    );
  }

  showTrack() {
    return Padding(
      // padding: const EdgeInsets.fromLTRB(23, 23, 23, 23),
      padding: const EdgeInsets.fromLTRB(23, 15, 15, 0),
      child: Row(
        children: [
          Container(
            child: Text(
              '0',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
          Container(
            child: Text(
              '20',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
          Container(
            child: Text(
              '40',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
          Container(
            child: Text(
              '60',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
          Container(
            child: Text(
              '80',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
          Container(
            child: Text(
              '100',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
