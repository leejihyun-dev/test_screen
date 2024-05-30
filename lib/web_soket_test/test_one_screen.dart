import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_screen_change/router_test/content_data.dart';
import 'package:test_screen_change/router_test/content_model.dart';
import 'package:test_screen_change/router_test/frame_model.dart';
import 'package:test_screen_change/router_test/layout_type.dart';
import 'package:test_screen_change/web_soket_test/web_soket_test.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/status.dart' as status;

final sendVideoUrlProvider = StateProvider<bool>((ref) {
  return false;
});

class TestOneScreen extends ConsumerStatefulWidget {
  const TestOneScreen({super.key});

  @override
  ConsumerState<TestOneScreen> createState() => _TestOneScreenState();
}

class _TestOneScreenState extends ConsumerState<TestOneScreen> {
  WebSocketChannel? _channel;
  bool _backState = false;
  String status = '';

  List<FrameModel> data = [
    // FrameModel(
    //   id: "f6554e87-44e6-4c4c-ba2c-b9753337a7d8",
    //   layoutType: LayoutType(
    //     code: 'TypeC',
    //     desc: "동영상",
    //   ),
    //   mainText: "",
    //   subText: "",
    //   useYn: "N",
    //   screenEffect: "",
    //   content: [
    //     ContentModel(
    //       id: "463cf508-2c49-4f18-8b74-93d4dcdc1e3e",
    //       transformTime: "18",
    //       content: ContentData(
    //           id: "8b9afd39-bb94-4cbf-aec7-d81e703cd650",
    //           filePath: "/ceo/",
    //           fileNm: "fe1221df-726e-42c7-be04-34c68c3219ec.mp4",
    //           thumbFileNm: null,
    //           fileOrgNm: "test_video.mp4",
    //           mimeTp: "video/mp4",
    //           fileSize: 1717916,
    //           thumbFileSize: null,
    //           oder: 0,
    //           createDt: "2024.03.21 10:35:56"),
    //     ),
    //   ],
    // ),
    // FrameModel(
    //   id: "f6554e87-44e6-4c4c-ba2c-b9753337a7d8",
    //   layoutType: LayoutType(
    //     code: 'TypeA',
    //     desc: "배경 이미지 1장",
    //   ),
    //   mainText: "테스트 메인",
    //   subText: "테스트 서브",
    //   useYn: "N",
    //   screenEffect: "페이드아웃",
    //   content: [
    //     ContentModel(
    //         id: "463cf508-2c49-4f18-8b74-93d4dcdc1e3e",
    //         transformTime: "3",
    //         content: ContentData(
    //             id: "8b9afd39-bb94-4cbf-aec7-d81e703cd650",
    //             filePath: "/intro/",
    //             fileNm: "755431fe-85c1-477f-83fb-08da313657c5.jpg",
    //             thumbFileNm: "755431fe-85c1-477f-83fb-08da313657c5_thumb.jpg",
    //             fileOrgNm: "2.png",
    //             mimeTp: "image/png",
    //             fileSize: 560130,
    //             thumbFileSize: 560130,
    //             oder: 0,
    //             createDt: "2024.03.21 10:35:56")),
    //     ContentModel(
    //         id: "463cf508-2c49-4f18-8b74-93d4dcdc1e3e",
    //         transformTime: "5",
    //         content: ContentData(
    //             id: "8b9afd39-bb94-4cbf-aec7-d81e703cd650",
    //             filePath: "/intro/",
    //             fileNm: "0162dc14-6fba-45f7-a275-61e63570280d.png",
    //             thumbFileNm: "0162dc14-6fba-45f7-a275-61e63570280d_thumb.png",
    //             fileOrgNm: "1.png",
    //             mimeTp: "image/png",
    //             fileSize: 610141,
    //             thumbFileSize: 610141,
    //             oder: 1,
    //             createDt: "2024.03.21 10:35:56")),
    // ContentModel(
    //   id: "463cf508-2c49-4f18-8b74-93d4dcdc1e3e",
    //   transformTime: "2",
    //   content: ContentData(
    //       id: "8b9afd39-bb94-4cbf-aec7-d81e703cd650",
    //       filePath: "/archiveCollection/",
    //       fileNm: "d5623e6d-b71b-489c-8356-ef30381d24ce.png",
    //       thumbFileNm: "d5623e6d-b71b-489c-8356-ef30381d24ce_thumb.png",
    //       fileOrgNm: "2.png",
    //       mimeTp: "image/png",
    //       fileSize: 560130,
    //       thumbFileSize: 560130,
    //       oder: 0,
    //       createDt: "2024.03.21 10:35:56"),
    // ),
    //   ],
    // ),
    FrameModel(
      id: "f6554e87-44e6-4c4c-ba2c-b9753337a7d8",
      layoutType: LayoutType(
        code: 'TYPE_C',
        desc: "이미지 1장",
      ),
      mainText: "",
      subText: "",
      useYn: "N",
      screenEffect: "",
      content: [
        ContentModel(
          id: "463cf508-2c49-4f18-8b74-93d4dcdc1e3e",
          transformTime: "62",
          content: ContentData(
              id: "8b9afd39-bb94-4cbf-aec7-d81e703cd650",
              filePath: "/media/",
              fileNm: "f0ac51d7-0f29-4e75-b7a0-22293fd6a3a3.mp4",
              thumbFileNm: "f0ac51d7-0f29-4e75-b7a0-22293fd6a3a3_thumb.png",
              fileOrgNm: "1.png",
              mimeTp: "video/mp4",
              fileSize: 610141,
              thumbFileSize: 610141,
              oder: 0,
              createDt: "2024.03.21 10:35:56"),
        ),
      ],
    ),
    // FrameModel(
    //   id: "f6554e87-44e6-4c4c-ba2c-b9753337a7d8",
    //   layoutType: LayoutType(
    //     code: 'TYPE_B',
    //     desc: "배경 이미지 1장",
    //   ),
    //   mainText: "",
    //   subText: "",
    //   useYn: "N",
    //   screenEffect: "페이드아웃",
    //   content: [
    //     ContentModel(
    //       id: "45e354d7-9590-4c99-b567-5e20e7150d7a",
    //       transformTime: "3",
    //       content: ContentData(
    //           id: "f6def7f2-3c3d-4f16-89ac-1f67a5f1cebe",
    //           filePath: "/ceo/",
    //           fileNm: "85da311c-3960-4953-a8ba-1f3a81ed8b31.png",
    //           thumbFileNm: "85da311c-3960-4953-a8ba-1f3a81ed8b31_thumb.png",
    //           fileOrgNm: "filter1.png",
    //           mimeTp: "image/png",
    //           fileSize: 10545,
    //           thumbFileSize: 1673,
    //           oder: 0,
    //           createDt: "2024.03.21 10:35:56"),
    //     ),
    //   ],
    // ),
    // FrameModel(
    //   id: "f6554e87-44e6-4c4c-ba2c-b9753337a7d8",
    //   layoutType: LayoutType(
    //     code: 'TYPE_A',
    //     desc: "이미지 1장",
    //   ),
    //   mainText: "테스트 메인",
    //   subText: "위로올라가",
    //   useYn: "N",
    //   screenEffect: "위로 올라가기",
    //   content: [
    //     ContentModel(
    //       id: "463cf508-2c49-4f18-8b74-93d4dcdc1e3e",
    //       transformTime: "3",
    //       content: ContentData(
    //           id: "8b9afd39-bb94-4cbf-aec7-d81e703cd650",
    //           filePath: "/ceo/",
    //           fileNm: "85da311c-3960-4953-a8ba-1f3a81ed8b31.png",
    //           thumbFileNm: "951f5d39-e24c-463c-8cd5-afbc232e5f6e_thumb.jpg",
    //           fileOrgNm: "1.png",
    //           mimeTp: "image/png",
    //           fileSize: 1087176,
    //           thumbFileSize: 104638,
    //           oder: 0,
    //           createDt: "2024.03.21 10:35:56"),
    //     ),
    //     ContentModel(
    //       id: "463cf508-2c49-4f18-8b74-93d4dcdc1e3e",
    //       transformTime: "3",
    //       content: ContentData(
    //           id: "8b9afd39-bb94-4cbf-aec7-d81e703cd650",
    //           filePath: "/ceo/",
    //           fileNm: "85da311c-3960-4953-a8ba-1f3a81ed8b31.png",
    //           thumbFileNm: "804faf2b-9779-4f08-8326-e96f1dda9b90_thumb.jpg",
    //           fileOrgNm: "1.png",
    //           mimeTp: "image/png",
    //           fileSize: 513898,
    //           thumbFileSize: 337042,
    //           oder: 0,
    //           createDt: "2024.03.21 10:35:56"),
    //     ),
    //   ],
    // ),
  ];

  @override
  void initState() {
    super.initState();
    connectChannel();
  }

  void connectChannel() {
    // _channel = WebSocketChannel.connect(Uri.parse(
    //     'ws://localhost:8080/ws/chat')); // 웹소켓 서버 정보 wss://echo.websocket.events
    // final msg = {
    //   "type": "ENTER",
    //   "roomId": "1",
    //   "name": "이지현",
    // };
    // _channel!.sink.add(jsonEncode(msg));
    _channel = IOWebSocketChannel.connect(
        //헤더를 보내야해서 수정함
        Uri.parse('ws://175.45.200.194:8080/api/player/conn'),
        headers: {
          'Authorization':
              'bearer eyJhbGciOiJIUzI1NiJ9.eyJJRCI6IlwiYWRtaW5cIiIsIlJPTEUiOiJbXCJST0xFXCIsXCJST0xFX0FETUlOXCJdIiwiaXNzIjoiZWxpZ2Eta2VkbSIsImlhdCI6MTcxNDM2MzI3OSwiZXhwIjoxNzE0OTY4MDc5fQ.lnYSahp44L1BamJvtuVOYR15qu4AV-CJVttGXqPpvag'
        });
    // final msg = {
    //   "msg": "test!????",
    // };
    // _channel!.sink.add(jsonEncode(msg));
    _listen();
  }

  _listen() async {
    //연결 끊김 감지하려고
    _channel!.stream.listen((event) {
      //리턴받는 메세지 및 데이터값
      print('event $event');
      setState(() {
        status = event;
      });
    }, onError: (error) async {
      print('error $error');
      setState(() {
        status = error;
      });
    }, onDone: () async {
      //연결 끊기면 여기 탄다.
      print('connect done reconnecting');
      setState(() {
        status = 'reconnecting';
      });

      await Future.delayed(Duration(milliseconds: 1000));
      connectChannel(); //재연결 계속 시도하기
    });
  }

  @override
  void dispose() {
    super.dispose();
    print('TestOneScreen dispose');
  }

  @override
  Widget build(BuildContext context) {
    final isVideoUrl = ref.watch(sendVideoUrlProvider);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              status,
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    final msg = {
                      "sender": "controller",
                      "menu": 1,
                      "msg": 'menu',
                      "data": data,
                    };
                    // String test = '/media/';
                    // String filePath = test.replaceAll('/', '');
                    // final msg = {
                    //   "sender": "controller",
                    //   "msg": 'mediaFirstStart',
                    //   "data":
                    //       '$filePath&1af88d98-ff90-41b0-992a-84358281d2b8.mp4',
                    // };
                    _channel!.sink.add(jsonEncode(msg));

                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => WebSoketScreen(),
                      ),
                    );
                    if (result == 'playing_back') {
                      print('여기타나요? playing_back');
                      setState(() {
                        _backState = true;
                      });
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () async {
                    String test = '/media/';
                    String filePath = test.replaceAll('/', '');
                    final msg = {
                      "sender": "controller",
                      "msg": 'mediaStart',
                      "data":
                          '$filePath&0f4180aa-61ac-4106-ba02-e6696c247d3b.mp4',
                    };
                    _channel!.sink.add(jsonEncode(msg));
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => WebSoketScreen(),
                      ),
                    );
                    if (result == 'playing_back') {
                      print('여기타나요? playing_back');
                      setState(() {
                        _backState = true;
                      });
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    String test = '/media/';
                    String filePath = test.replaceAll('/', '');
                    final msg = {
                      "sender": "controller",
                      "msg": 'mediasts',
                      "data":
                          '$filePath&4bb98402-c029-4b01-becf-ca053ddfe0f9.mp4',
                    };
                    _channel!.sink.add(jsonEncode(msg));
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => WebSoketScreen(),
                      ),
                    );
                    if (result == 'playing_back') {
                      print('여기타나요? playing_back');
                      setState(() {
                        _backState = true;
                      });
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.yellow,
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.purple,
                ),
              ],
            ),
            Visibility(
              visible: _backState,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => WebSoketScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
