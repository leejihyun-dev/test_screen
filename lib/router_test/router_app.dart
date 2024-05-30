import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_screen_change/router_test/go_main_provider.dart';
import 'package:test_screen_change/router_test/router.dart';

class RouterApp extends ConsumerStatefulWidget {
  const RouterApp({super.key});

  @override
  ConsumerState<RouterApp> createState() => _RouterAppState();
}

class _RouterAppState extends ConsumerState<RouterApp> {
  @override
  void initState() {
    mainContext = context;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'RouterApp',
      routerConfig: ref.watch(routerProvider),
    );
  }
}
