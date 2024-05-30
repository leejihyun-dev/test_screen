import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_screen_change/router_test/controller.dart';
import 'package:test_screen_change/router_test/frame_model.dart';
import 'package:test_screen_change/router_test/frame_view.dart';

class TestView extends ConsumerStatefulWidget {
  static String get routeName => 'TestView';
  const TestView({super.key, this.index = '0'});
  final String index;

  @override
  ConsumerState<TestView> createState() => _TestViewState();
}

class _TestViewState extends ConsumerState<TestView> {
  int test = 0;

  @override
  void initState() {
    test = int.parse(widget.index);
    super.initState();
    List<FrameModel> frames = ref.read(frameDataProvider); //데이터리스트

    print('frames $frames');
    Timer.periodic(Duration(seconds: int.parse(frames[test].transformTime!)),
        (timer) {
      if (test == frames.length - 1) {
        test = 0;
      } else {
        test++;
      }
      if (mounted) {
        context.push('/screen/$test');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<FrameModel> frames = ref.read(frameDataProvider); //데이터리스트
    final LayoutTypes type = LayoutTypes.values.byName(
        frames[int.parse(widget.index)].layoutType!.code!.toLowerCase());

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: LayoutTypes.typec == type //영상일 경우
                ? Stack(
                    children: [
                      Image.asset('assets/home_bg.png'),
                    ],
                  )
                : LayoutTypes.typea == type
                    ? Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                            //제목, 내용이 없는 경우
                            top: frames[int.parse(widget.index)]
                                        .mainText!
                                        .isEmpty &&
                                    frames[int.parse(widget.index)]
                                        .subText!
                                        .isEmpty
                                ? 280
                                : 200,
                            left: frames[int.parse(widget.index)]
                                        .mainText!
                                        .isEmpty &&
                                    frames[int.parse(widget.index)]
                                        .subText!
                                        .isEmpty
                                ? 500
                                : 200,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.asset(
                              'assets/view_image_sample.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Image.asset(
                        'assets/view_image_sample.png',
                        fit: BoxFit.cover,
                      ),
            // widget.index == '0'
            //     ? Image.asset(
            //         'assets/home_bg.png',
            //         fit: BoxFit.cover,
            //       )
            //     : Image.asset('assets/view_image_sample.png',
            //         fit: BoxFit.cover),
          ),
          // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          //   ElevatedButton(
          //     onPressed: () {
          //       context.push('/screen/0');
          //     },
          //     child: const Text('screen 0'),
          //   ),
          //   ElevatedButton(
          //     onPressed: () {
          //       context.push('/screen/1');
          //     },
          //     child: const Text('screen 1'),
          //   ),
          // ]),
          Center(
            child: Text(
              widget.index.toString(),
              style: const TextStyle(fontSize: 30, color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
