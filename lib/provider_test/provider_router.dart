import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_screen_change/bottom_navigation_test/bottom_screen.dart';
import 'package:test_screen_change/provider_test/provider_main.dart';

part 'provider_router.g.dart';

@riverpod
GoRouter router(RouterRef ref) =>
    GoRouter(initialLocation: '/', debugLogDiagnostics: true, routes: [
      GoRoute(
        path: '/',
        //name: ProviderMain.routeName,
        name: BottomScreen.routeName,
        pageBuilder: (context, state) => NoTransitionPage(
          //child: ProviderMain(),
          child: BottomScreen(),
        ),
        // routes: [
        //   GoRoute(path: 'provider',
        //   name: Provider
        //   )
        // ]
      )
    ]);
