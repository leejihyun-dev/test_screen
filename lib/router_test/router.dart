import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_screen_change/router_test/frame_view.dart';
import 'package:test_screen_change/router_test/home_view.dart';
import 'package:test_screen_change/router_test/test_view.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeView(),
          ),
        ),
        GoRoute(
          path: '/screen/:id',
          pageBuilder: (context, state) => CustomTransitionPage(
            maintainState: false,
            child: TestView(
              index: state.pathParameters['id'] as String,
            ),
            transitionDuration: const Duration(milliseconds: 500),
            reverseTransitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final test = ref.read(frameDataProvider);
              String test2 =
                  test[int.parse(state.pathParameters['id']!)].screenEffect!;

              if (test2 == '위로 올라가기') {
                return SlideTransition(
                  position: animation.drive(Tween<Offset>(
                      begin: const Offset(0, 1.0), end: Offset.zero)),
                  child: child,
                );
              } else if (test2 == '페이드아웃') {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              } else {
                return SlideTransition(
                  position: animation.drive(Tween<Offset>(
                      begin: const Offset(0, -1.0), end: Offset.zero)),
                  child: child,
                );
              }
            },
          ),
        ),
        // GoRoute(
        //   path: '/frame/:frameId',
        //   name: FrameView.routeName,
        //   pageBuilder: (context, state) {
        //     final playlist = ref.read(currentDataProvider);
        //     String animationType = playlist.screenEffect!;

        //     return CustomTransitionPage(
        //       key: UniqueKey(),
        //       // maintainState: false,
        //       child: FrameView(
        //         key: UniqueKey(),
        //         frameId: state.pathParameters['frameId']!,
        //       ),
        //       transitionDuration: const Duration(milliseconds: 500),
        //       transitionsBuilder:
        //           (context, animation, secondaryAnimation, child) {
        //         if ('페이드아웃' == animationType) {
        //           return FadeTransition(
        //             opacity: animation,
        //             child: child,
        //           );
        //         } else if ('위로 올라가기' == animationType) {
        //           return SlideTransition(
        //             position: animation.drive(Tween<Offset>(
        //                 begin: const Offset(0, 1.0), end: Offset.zero)),
        //             child: child,
        //           );
        //         } else {
        //           return SlideTransition(
        //             key: UniqueKey(),
        //             position: animation.drive(Tween<Offset>(
        //                 begin: const Offset(0, -1.0), end: Offset.zero)),
        //             child: child,
        //           );
        //         }
        //       },
        //     );
        //   },
        // ),
      ],
    );
