import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_screen_change/router_test/controller.dart';
import 'package:test_screen_change/router_test/frame_model.dart';
import 'package:test_screen_change/router_test/go_main_provider.dart';
import 'package:test_screen_change/router_test/image_view.dart';
import 'package:test_screen_change/router_test/layout_type.dart';
import '../../../main.dart';

enum ScreenType {
  text,
  video,
}

enum LayoutTypes {
  //화면 타입 typeA:기본이미지한장, typeB: 배경지정, typeC: 영상
  typea,
  typeb,
  typec,
}

final currentFrameIdProvider = StateProvider<int>((ref) => -1);
final currentDataProvider = StateProvider<FrameModel>((ref) => FrameModel());
final frameDataProvider = StateProvider<List<FrameModel>>((ref) => [
      FrameModel(
        id: "f6554e87-44e6-4c4c-ba2c-b9753337a7d8",
        layoutType: LayoutType(
          code: 'TypeA',
          desc: "배경 이미지 1장",
        ),
        mainText: "테스트 메인",
        subText: "테스트 서브",
        useYn: "N",
        screenEffect: "페이드아웃", //페이드아웃
        transformTime: '3',
      ),
      FrameModel(
        id: "f6554e87-44e6-4c4c-ba2c-b9753337a7d8",
        layoutType: LayoutType(
          code: 'TypeB',
          desc: "이미지 1장",
        ),
        mainText: "",
        subText: "테스트 서브",
        useYn: "N",
        screenEffect: "아래로 내려가기",
        transformTime: '3',
      ),
      // FrameModel(
      //   id: "f6554e87-44e6-4c4c-ba2c-b9753337a7d8",
      //   layoutType: LayoutType(
      //     code: 'TypeB',
      //     desc: "이미지 1장",
      //   ),
      //   mainText: "서브",
      //   subText: "테스트 서브",
      //   useYn: "N",
      //   screenEffect: "아래로 내려가기",
      //   transformTime: '3',
      // ),
    ]);

class FrameView extends ConsumerStatefulWidget {
  static String get routeName => 'FrameView';
  final String? frameId;
  const FrameView({
    super.key,
    this.frameId = '0',
  });

  @override
  ConsumerState<FrameView> createState() => _FrameViewState();
}

class _FrameViewState extends ConsumerState<FrameView> {
  FrameModel curData = FrameModel();
  int frameIndex = 0;

  @override
  void initState() {
    print('initState ${widget.frameId}');
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   ref.read(currentFrameIdProvider.notifier).state =
    //       int.parse(widget.frameId!);
    //   ref.read(frameControllerProvider(frameId: widget.frameId!));
    // });

    frameIndex = int.parse(widget.frameId!);
    super.initState();
  }

  void init() {
    final frame = ref.read(frameDataProvider);

    Timer.periodic(Duration(seconds: 5), (timer) {
      if (frameIndex == 1) {
        frameIndex = 0;
      } else {
        frameIndex++;
      }
      if (mounted) {
        context.push('/frame/$frameIndex');
      }
    });
  }

  @override
  void deactivate() {
    print('deactivate ${widget.frameId}');
    ref
        .read(frameControllerProvider(frameId: widget.frameId!).notifier)
        .dispose();
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose ${widget.frameId}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curData = ref.watch(currentDataProvider);

    final LayoutTypes type =
        LayoutTypes.values.byName(curData.layoutType!.code!.toLowerCase());

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/home_bg.png',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 1920,
          height: 1080,
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
                          top: curData.mainText!.isEmpty &&
                                  curData.subText!.isEmpty
                              ? 280
                              : 200,
                          left: curData.mainText!.isEmpty &&
                                  curData.subText!.isEmpty
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
        ),
      ],
    );
  }
}
