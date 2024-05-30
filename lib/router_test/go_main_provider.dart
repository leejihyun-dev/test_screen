import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_screen_change/router_test/frame_model.dart';
import 'package:test_screen_change/router_test/frame_view.dart';

BuildContext? mainContext;

final goMainbyProvider = StateNotifierProvider<GoMainNotifier, bool>((ref) {
  return GoMainNotifier(ref: ref);
});

class GoMainNotifier extends StateNotifier<bool> {
  final Ref ref;
  GoMainNotifier({
    required this.ref,
  }) : super(false);

  Timer? timer;
  void check() {
    state = false;
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }

    timer = Timer(const Duration(seconds: 2), () {
      state = true;
      List<FrameModel> frames = ref.read(frameDataProvider);
      ref.read(currentDataProvider.notifier).state = frames[0];
      // mainContext!.push('/frame/0');
      mainContext!.push('/screen/0');
      // mainContext!.goNamed(
      //   FrameView.routeName,
      //   pathParameters: {'frameId': '0'},
      // );
    });
  }

  bool stateCheck() {
    return state;
  }
}
