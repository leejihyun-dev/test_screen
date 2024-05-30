import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_screen_change/router_test/go_main_provider.dart';

class HomeView extends ConsumerStatefulWidget {
  final String? framdId;
  const HomeView({super.key, this.framdId = '0'});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}
//소켓값으로 메뉴값도 받아야함 kesco, ceo,는 피피티, media는 영상

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    mainContext = context;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(goMainbyProvider.notifier).check();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 1920,
        height: 1080,
        child: Container(
          color: Colors.blue,
          child: const Center(
            child: Text(
              'CMS에서 등록한 대기영상이 나올 예정입니다.',
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
          ),
        ),
      ),
    );
  }
}
