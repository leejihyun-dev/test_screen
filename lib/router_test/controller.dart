import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_screen_change/router_test/frame_model.dart';
import 'package:test_screen_change/router_test/frame_view.dart';
import 'package:test_screen_change/router_test/go_main_provider.dart';
import 'dart:developer' as developer;

import 'package:test_screen_change/router_test/test_view.dart';

part 'controller.g.dart';

//프레임 컨트롤러는 프레임이 매번 바뀌고 재 사용 하므로 (autoDispose)가 아니여야 한다. keepAlive를 사용 한다.
@riverpod
class FrameController extends _$FrameController {
  // late FrameList _frame;

  Timer? _timer;

  KeepAliveLink? link;

  @override
  FutureOr<void> build({required String frameId}) async {
    developer.log('FrameController ---------------------------------$frameId');

    link = ref.keepAlive(); //이게 없으면 화면을 다시 안 그린다. 긍까 한 번만 화면을 그림

    ref.onDispose(() {
      _timer?.cancel();
      developer
          .log('FrameController --------------------------------- onDispose()');
    });
    init();
  }

  void init() {
    _timer?.cancel();
    int currentIndex = ref.read(currentFrameIdProvider); //현재 인덱스
    List<FrameModel> frames = ref.read(frameDataProvider); //데이터리스트

    _timer = Timer(
        Duration(seconds: int.parse(frames[currentIndex].transformTime!)), () {
      //=>다음 인덱스 프레임으로
      int framesTotal = frames.length; //데이터 길이

      int nextIndex;
      nextIndex = currentIndex + 1; //다음 인덱스
      if (nextIndex > framesTotal - 1) {
        //끝까지 돌았다면
        nextIndex = 0;
      }

      ref.read(currentDataProvider.notifier).state =
          frames[nextIndex]; //현재 데이터의 애니메이션 파악을 위해
      gotoFrameByEnd(frameId: nextIndex.toString()); //화면 이동
    });
  }

  void dispose() {
    developer
        .log('FrameController --------------------------------- dispose()');
    link?.close(); //신기하다 이게 없으면 끝까지 돌은 후 맨처음으로 돌아가면 다시 시작되지 않아

    _timer?.cancel();
  }

  //프래임 끝나고 이동
  void gotoFrameByEnd({required String frameId}) {
    _timer?.cancel();
    print('frame gotoFrameByEnd $frameId');
    // mainContext!
    //     .pushNamed(FrameView.routeName, pathParameters: {'frameId': frameId});
    mainContext!.push('/frame/$frameId');
  }
}
