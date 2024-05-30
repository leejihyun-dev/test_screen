import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:test_screen_change/web_soket_test/test_one_screen.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

//클라이언트1 (컨트롤러)
class WebSoketScreen extends ConsumerStatefulWidget {
  const WebSoketScreen({super.key});

  @override
  ConsumerState<WebSoketScreen> createState() => _WebSoketScreenState();
}

class _WebSoketScreenState extends ConsumerState<WebSoketScreen>
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
  String status = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    connectChannel();
    init();
  }

  void selectDelay() {
    //재생시간 보여줬다가 다시 없애는 애니메이션 주려고 추가함
    Future.delayed(const Duration(milliseconds: 500), () {
      // setState(() {
      _selectedTimeVisible = false;
      // });
    });
  }

  void connectChannel() {
    //서버 연결 시도

    // _channel = WebSocketChannel.connect(Uri.parse(
    //     'ws://localhost:8080/ws/chat'),
    //     ); // 웹소켓 서버 정보 wss://echo.websocket.events
    _channel = IOWebSocketChannel.connect(
        //헤더를 보내야해서 수정함
        Uri.parse('ws://175.45.200.194:8080/api/player/conn'),
        headers: {
          'Authorization':
              'bearer eyJhbGciOiJIUzI1NiJ9.eyJJRCI6IlwiYWRtaW5cIiIsIlJPTEUiOiJbXCJST0xFXCIsXCJST0xFX0FETUlOXCJdIiwiaXNzIjoiZWxpZ2Eta2VkbSIsImlhdCI6MTcxMzg1MjAyOCwiZXhwIjoxNzE0NDU2ODI4fQ.--UsrLlDm-neCcpvD0y8dnKul4Gf-kxJVVqwUGjXJKw'
        });
    // final msg = {
    //   "msg": "test!",
    // };
    // _channel = WebSocketChannel.connect(Uri.parse(
    //     'ws://localhost:8080/ws/chat')); // 웹소켓 서버 정보 wss://echo.websocket.events
    // final msg = {
    //   "type": "ENTER",
    //   "roomId": "1",
    //   "name": "이지현???",
    // };
    // _channel.sink.add(jsonEncode(msg));
    _listen();
  }

  Future<void> init() async {
    // final talkMsg = {
    //   "type": "TALK",
    //   "roomId": "1",
    //   "sender": "chee",
    //   "msg": 'play',
    //   "length": "",
    //   "playLength": "",
    // };
    // _channel.sink.add(jsonEncode(talkMsg));
  }

  _listen() async {
    //연결 끊김 감지하려고
    _channel.stream.listen((event) async {
      //리턴받는 메세지 및 데이터값
      print('event $event');
      status = event;
      Map<String, dynamic> data = json.decode(event);
      setState(() {
        // if (data['ms'] == 'totalLength') {
        //   totalLength = data['msg'];
        //   _testduration =
        //       double.parse(data['playLength']); //_totalDuration;
        // }
        if (data['sender'] == 'monitor') {
          if (data['msg'] == 'totalLength') {
            totalLength = data['data'];
          }
          if (data['msg'] == 'currentLength') {
            totalLength = data['totalMessage'];
            _testduration =
                double.parse(data['sliderTotalPlayLength']); //_totalDuration;
            List<String> timeParts = data['playLength'].split(":");
            int hours = int.parse(timeParts[0]);
            int minutes = int.parse(timeParts[1]);
            List<String> secondsAndMilliseconds = timeParts[2].split(".");
            int seconds = int.parse(secondsAndMilliseconds[0]);
            int milliseconds = int.parse(secondsAndMilliseconds[1]);

            Duration _current = Duration(
              hours: hours,
              minutes: minutes,
              seconds: seconds,
              milliseconds: milliseconds,
            );

            currentLength = data['data'];

            _position = _current;
          }
        }
      });
      if (data['msg'] == 'playState') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                title: Text("Test"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '끝.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text("확인"),
                    onPressed: () {
                      final talkMsg = {
                        "sender": "controller",
                        "msg": 'goHome',
                      };
                      _channel.sink.add(jsonEncode(talkMsg));
                    },
                  ),
                  ElevatedButton(
                    child: Text("다시보기기"),
                    onPressed: () {
                      Navigator.pop(context);
                      final talkMsg = {
                        "sender": "controller",
                        "msg": 'replay',
                        "menu": '0',
                      };
                      _channel.sink.add(jsonEncode(talkMsg));
                    },
                  ),
                ],
              );
            });
      }
    }, onError: (error) async {
      print('error $error');
      setState(() {
        status = error;
      });
    }, onDone: () async {
      //연결 끊기면 여기 탄다.
      print('connect done reconnecting');
      // setState(() {
      //   status = 'reconnecting';
      // });

      await Future.delayed(Duration(milliseconds: 1000)).then((value) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                title: Text("Test"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '서버와 연결이 끊겼습니다.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text("확인"),
                    onPressed: () {
                      Navigator.pop(context, 'reconnect');
                    },
                  ),
                ],
              );
            });
      });

      // ref.read(sendVideoUrlProvider.notifier).state = false;
      // connectChannel(); //재연결 계속 시도하기
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    // print('Websokect dispose');
    // _channel.sink.close(); //소켓 서버 연결 끊기
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
            Text(
              status,
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'back',
                  //영상 넘기기
                  onPressed: () {
                    print('click back');
                    // final talkMsg = {
                    //   "sender": "controller",
                    //   "msg": 'goHome',
                    //   'data': '',
                    // };
                    // _channel.sink.add(jsonEncode(talkMsg));
                    Navigator.pop(context, 'playing_back');
                  },
                  child: Icon(Icons.keyboard_return_rounded),
                ),
                FloatingActionButton(
                  heroTag: 'home',
                  //홈으로 돌아가기 테스트
                  onPressed: () {
                    final talkMsg = {
                      "sender": "controller",
                      "msg": 'playbar',
                      'data': 'stop',
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
                      "sender": "controller",
                      "msg": 'playbar',
                      'data': 'play',
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
                      "sender": "controller",
                      "msg": 'playbar',
                      'data': 'volumnOn',
                    };
                    _channel.sink.add(jsonEncode(talkMsg));
                  },
                  child: Icon(Icons.volume_up_rounded),
                ),
                FloatingActionButton(
                  heroTag: 'volumnmute',
                  onPressed: () {
                    final talkMsg = {
                      "sender": "controller",
                      "msg": 'playbar',
                      'data': 'volumnMute',
                    };
                    _channel.sink.add(jsonEncode(talkMsg));
                  },
                  child: Icon(Icons.volume_off_rounded),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
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
                                double sliderWidth =
                                    screenWidth - 80; // 슬라이더의 좌우 여백을 고려하여 계산
                                double left =
                                    (value / maxSliderValue) * sliderWidth;

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
                                int minutes = (value.toInt() / 60).floor();
                                int seconds = (value.toInt() % 60).floor();

                                if (minutes < 10) {
                                  _minutes = '0$minutes';
                                } else {
                                  if (minutes >= 60) {
                                    //영상 1시간 이상일 경우 처리
                                    int selectedHours = (minutes / 60).floor();
                                    minutes %= 60;
                                    String formattedMinutes =
                                        minutes < 10 ? '0$minutes' : '$minutes';
                                    _minutes =
                                        '${selectedHours.toString().padLeft(2, '0')} : $formattedMinutes';
                                  } else {
                                    //아닐 경우 10분 미만이면 0을 붙여준다.
                                    _minutes =
                                        minutes < 10 ? '0$minutes' : '$minutes';
                                  }
                                }
                                if (seconds < 10) {
                                  _seconds = '0$seconds';
                                } else {
                                  _seconds = '$seconds';
                                }

                                final talkMsg = {
                                  "sender": "controller",
                                  "msg": 'playbar',
                                  'data': 'stop',
                                };
                                _channel.sink.add(jsonEncode(talkMsg));

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        title: Text("Test"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '선택하신 $_minutes:$_seconds부터 영상을\n이동 재생하시겠습니까?',
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: Text("취소"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              final talkMsg = {
                                                "sender": "controller",
                                                "msg": 'playbar',
                                                'data': 'play',
                                              };
                                              _channel.sink
                                                  .add(jsonEncode(talkMsg));
                                            },
                                          ),
                                          ElevatedButton(
                                            child: Text("재생"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              final talkMsg = {
                                                "sender": "controller",
                                                "msg": 'playbar',
                                                'data': '${value.toInt()}',
                                              };
                                              _channel.sink
                                                  .add(jsonEncode(talkMsg));
                                            },
                                          ),
                                        ],
                                      );
                                    });
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
            ),
            // StreamBuilder(
            //     stream: _channel.stream,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         Map<String, dynamic> data =
            //             json.decode(snapshot.data.toString());
            // if (data['sender'] == 'totalLength') {
            //   totalLength = data['msg'];
            //   _testduration =
            //       double.parse(data['playLength']); //_totalDuration;
            // }
            // if (data['sender'] == 'currentLength') {
            //   totalLength = data['totalMessage'];
            //   _testduration = double.parse(
            //       data['totalPlayLength']); //_totalDuration;

            //   List<String> timeParts = data['playLength'].split(":");
            //   int hours = int.parse(timeParts[0]);
            //   int minutes = int.parse(timeParts[1]);
            //   List<String> secondsAndMilliseconds =
            //       timeParts[2].split(".");
            //   int seconds = int.parse(secondsAndMilliseconds[0]);
            //   int milliseconds = int.parse(secondsAndMilliseconds[1]);

            //   Duration _current = Duration(
            //     hours: hours,
            //     minutes: minutes,
            //     seconds: seconds,
            //     milliseconds: milliseconds,
            //   );

            //   currentLength = data['msg'];

            //   _position = _current;
            // }
            // return
            // } else {
            // return Padding(
            //   padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            //   child: Column(
            //     children: [
            //       Stack(
            //         children: [
            //           Positioned(
            //             //클릭한 위치 재생시간 보여주는거
            //             top: 0,
            //             left: selectedPosition.toDouble(),
            //             child: AnimatedOpacity(
            //               opacity: _selectedTimeVisible ? 1.0 : 0.0,
            //               duration: Duration(milliseconds: 300),
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                   color: Colors.white,
            //                   borderRadius: BorderRadius.circular(5),
            //                 ),
            //                 child: Padding(
            //                   padding: EdgeInsets.all(5),
            //                   child: Text(
            //                     '$_minutes : $_seconds',
            //                     style: TextStyle(
            //                       fontSize: 15,
            //                       color: Colors.red,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: EdgeInsets.only(top: 30),
            //             child: SliderTheme(
            //               data: SliderThemeData(
            //                 trackHeight: 20,
            //                 activeTrackColor: Colors.blue.shade300,
            //                 inactiveTrackColor: Color(0xFF757575),
            //                 thumbColor: Colors.amber,
            //                 thumbShape: RoundSliderThumbShape(
            //                     enabledThumbRadius: 20),
            //                 overlayColor:
            //                     Color(0xFFCDDC39).withOpacity(0.2),
            //                 overlayShape: RoundSliderOverlayShape(
            //                     overlayRadius: 30),
            //               ),
            //               child: Slider(
            //                 min: 0,
            //                 max: 1,
            //                 value: _position.inSeconds.toDouble(),
            //                 onChanged: (value) {},
            //                 onChangeEnd: (value) {},
            //               ),
            //             ),
            //           ),
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
            // return Padding(
            //   padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            //   child: Column(
            //     children: [
            //       SizedBox(
            //         width: 200,
            //         child: FloatingActionButton(
            //           heroTag: 'reconnect',
            //           //재연결 버튼
            //           onPressed: () {
            //             _channel.sink.close();
            //             _channel = WebSocketChannel.connect(Uri.parse(
            //                 'ws://localhost:8080/ws/chat')); // 웹소켓 서버 정보 wss://echo.websocket.events
            //             final msg = {
            //               "type": "ENTER",
            //               "roomId": "1",
            //               "name": "이지현???",
            //             };
            //             _channel.sink.add(jsonEncode(msg));
            //           },
            //           child: Text('연결이 끊겼어요.!\n재연결하기'),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 30,
            //       ),
            //     ],
            //   ),
            // );
            // }

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
            // }),
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
