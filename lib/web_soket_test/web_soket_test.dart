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

// //테스트
  double _testduration = 0.0;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  String _minutes = '';
  String _seconds = '';

  int selectedPosition = 0;
  bool _selectedTimeVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    connectChannel();
  }

  void selectDelay() {
    //재생시간 보여줬다가 다시 없애는 애니메이션 주려고 추가함
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _selectedTimeVisible = false;
      });
    });
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
                      _testduration =
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
                    }
                    return Padding(
                      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Positioned(
                                //클릭한 위치 재생시간 보여주는거
                                top: 0,
                                left: selectedPosition.toDouble(),
                                child: AnimatedOpacity(
                                  opacity: _selectedTimeVisible ? 1.0 : 0.0,
                                  duration: Duration(milliseconds: 300),
                                  // opacity: _animation,
                                  // turns: _animationController,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        '$_minutes : $_seconds',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 20, //진행바 높이
                                    activeTrackColor:
                                        Colors.blue.shade300, //채워지는 색
                                    inactiveTrackColor: Color(0xFF757575), //진행바
                                    thumbColor: Colors.amber, //진행버튼 색
                                    thumbShape: //진행버튼 크기조절
                                        RoundSliderThumbShape(
                                            enabledThumbRadius: 20),
                                    //
                                    overlayColor:
                                        Color(0xFFCDDC39).withOpacity(0.2),
                                    overlayShape: //버튼 눌렀을 때 퍼짐 효과
                                        RoundSliderOverlayShape(
                                            overlayRadius: 30),
                                  ),
                                  child: Slider(
                                    //test
                                    min: 0,
                                    max: _testduration,
                                    value: _position.inSeconds.toDouble(),
                                    onChanged: (value) {},
                                    onChangeEnd: (value) {
                                      setState(() {
                                        ///이부분은 클릭한 위치에 재생시간 보여주기
                                        double maxSliderValue = //재생 전체 길이
                                            _testduration;
                                        double screenWidth = //현재 화면 너비
                                            MediaQuery.of(context).size.width;
                                        double sliderWidth = screenWidth -
                                            80; // 슬라이더의 좌우 여백을 고려하여 계산
                                        double left = (value / maxSliderValue) *
                                            sliderWidth;

                                        /** 
                                       * value / maxSliderValue => Slider의 현재 위치가 전체 재생길이에서 차지하는 비율을 계산한다.
                                       * (value / maxSliderValue) * sliderWidth => 이 비율에 sliderWidth를 곱해 전체 화면의 위치를 결정한다.
                                       * slider값이 0일때 화면 좌측 끝, 최대값일때 화면 우측 끝에 위치하며 그 사이 값은 비례하여 중간에 위치하게 된다.
                                       * 
                                      */

                                        // Positioned 위젯의 left 값을 업데이트
                                        selectedPosition = left.toInt();

                                        _selectedTimeVisible = true;

                                        selectDelay();

                                        ////
                                        //선택한 재생시간 계산하기
                                        int minutes =
                                            (value.toInt() / 60).floor();
                                        int seconds =
                                            (value.toInt() % 60).floor();

                                        if (minutes < 10) {
                                          _minutes = '0$minutes';
                                        } else {
                                          if (minutes >= 60) {
                                            //영상 1시간 이상일 경우 처리
                                            int selectedHours =
                                                (minutes / 60).floor();
                                            minutes %= 60;
                                            String formattedMinutes =
                                                minutes < 10
                                                    ? '0$minutes'
                                                    : '$minutes';
                                            _minutes =
                                                '${selectedHours.toString().padLeft(2, '0')} : $formattedMinutes';
                                          } else {
                                            //아닐 경우 10분 미만이면 0을 붙여준다.
                                            _minutes = minutes < 10
                                                ? '0$minutes'
                                                : '$minutes';
                                          }
                                        }
                                        if (seconds < 10) {
                                          _seconds = '0$seconds';
                                        } else {
                                          _seconds = '$seconds';
                                        }

                                        final test = value.toInt();
                                        final talkMsg = {
                                          "type": "TALK",
                                          "roomId": "1",
                                          "sender": "end",
                                          "msg": 'playProgressbar',
                                          "length": "$test",
                                          "playLength": "",
                                        };
                                        _channel.sink.add(jsonEncode(talkMsg));
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
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
