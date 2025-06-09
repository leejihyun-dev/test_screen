import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:test_screen_change/3D_list/list_test.dart';
import 'package:test_screen_change/animation_test/animation_test.dart';
import 'package:test_screen_change/builder_test/future_builder.dart';
import 'package:test_screen_change/camera_windows_test/camera_windows.dart';
import 'package:test_screen_change/camera_windows_test/test_img_select.dart';
import 'package:test_screen_change/card_test/card_screen.dart';
import 'package:test_screen_change/carousel_slider_test/carousel_slider.dart';
import 'package:test_screen_change/datepicker/date_picker_test.dart';
import 'package:test_screen_change/drawing_test/drawing_test.dart';
import 'package:test_screen_change/font_test/font_screen.dart';
import 'package:test_screen_change/history_test/history_test.dart';
import 'package:test_screen_change/image_grid_masonry/image_grid_screen.dart';
import 'package:test_screen_change/image_grid_masonry/test_grid_screen.dart';
import 'package:test_screen_change/img_merge_test/img_merge_test.dart';
import 'package:test_screen_change/keyboard_test/keyboard_service.dart';
import 'package:test_screen_change/keyboard_test/keyboard_test.dart';
import 'package:test_screen_change/localization/localization_screen.dart';
import 'package:test_screen_change/marquee_test/marquee_view.dart';
import 'package:test_screen_change/media_test/fitted_screen.dart';
import 'package:test_screen_change/padding_test/padding_test.dart';
import 'package:test_screen_change/pageview_build_test/pageview_container.dart';
import 'package:test_screen_change/pageview_build_test/test.dart';
import 'package:test_screen_change/pdf_test/pdf_screen.dart';
import 'package:test_screen_change/pdf_test/pdf_screen_two.dart';
import 'package:test_screen_change/provider_test/provider_main.dart';
import 'package:test_screen_change/provider_test/provider_router.dart';
import 'package:test_screen_change/records/records.dart';
import 'package:test_screen_change/router_test/router_app.dart';
import 'package:test_screen_change/scroll_bar/scroll_bar_listview_screen.dart';
import 'package:test_screen_change/scroll_bar/scroll_bar_screen.dart';
import 'package:test_screen_change/shut_down_test/shut_down_test.dart';
import 'package:test_screen_change/slidable_test/slidable_screen_test.dart';
import 'package:test_screen_change/sqlite_test/db_helper.dart';
import 'package:test_screen_change/sqlite_test/model/dog_model.dart';
import 'package:test_screen_change/sqlite_test/sqlite_screen.dart';
import 'package:test_screen_change/text_change_animation_test/text_change_screen.dart';
import 'package:test_screen_change/text_test.dart';
import 'package:test_screen_change/timer_periodic_test/timer_periodic.dart';
import 'package:test_screen_change/video_Test/video_screen.dart';
import 'package:test_screen_change/video_Test/video_screen_two.dart';
import 'package:test_screen_change/web_soket_test/socket_io_test.dart';
import 'package:test_screen_change/web_soket_test/test_one_screen.dart';
import 'package:test_screen_change/web_soket_test/test_two_screen.dart';
import 'package:test_screen_change/web_soket_test/web_soket_test.dart';
import 'package:test_screen_change/web_view/web_view.dart';
import 'package:test_screen_change/window_test/menuboard_test.dart';
import 'package:test_screen_change/window_test/window_test_screen.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final Set<PhysicalKeyboardKey> _pressedKeys = {};

void main() async {
  //runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await initializeDateFormatting();

  runApp(ProviderScope(
    child: KeyboardListenerWrapper(),
  ));
  // runApp(HistoryTest1());
}

class KeyboardListenerWrapper extends ConsumerWidget {
  const KeyboardListenerWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool _isTogglingFullScreen = false;

    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (KeyEvent key) async {
        if (_isTogglingFullScreen) return; // 이미 처리 중이면 무시
        _isTogglingFullScreen = true;

        if (key.logicalKey.keyLabel.toUpperCase() == 'F') {
          bool isFullScreen = await windowManager.isFullScreen();
          // F 키일 때 처리
          if (isFullScreen) {
            // ✅ 전체화면 상태에서 → 전체화면 해제
            print('여기 전체화면');
            await windowManager.setFullScreen(false);
            await windowManager.setTitleBarStyle(TitleBarStyle.normal);
          } else {
            // ✅ 일반 상태에서 → 전체화면 진입
            print('여기 일반');
            await windowManager.setFullScreen(true);
            await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
            await windowManager.setAsFrameless(); // 테두리 제거
          }
          await Future.delayed(const Duration(milliseconds: 300));
          _isTogglingFullScreen = false;
        }
      },
      child: const MyApp(),
    );
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  List<Dog> dogs = [
    Dog(name: '푸들이'),
    Dog(name: '삽살이'),
    Dog(name: '말티말티'),
    Dog(name: '강돌이'),
    Dog(name: '진져'),
    Dog(name: '백구'),
  ];

  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //     debugShowCheckedModeBanner: false,
    //     scrollBehavior: const MaterialScrollBehavior().copyWith(
    //       dragDevices: {
    //         PointerDeviceKind.mouse,
    //         PointerDeviceKind.touch,
    //         PointerDeviceKind.stylus,
    //         PointerDeviceKind.unknown
    //       },
    //     ),
    //     routerConfig: ref.watch(routerProvider)
    //     // home: TextChangeScreen()
    //     // home: Scaffold(body: HistoryTest()),
    //     );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // 실 기기에서 아래를 주석 처리하고 이 부분을 넣어야 한다.
        GlobalCupertinoLocalizations.delegate,
        // DefaultCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'), // Korean
        Locale('en', 'US'), // English
      ],
      home: Scaffold(
          // appBar: AppBar(
          //   title: Text('3D 목록 테스트 해보기'),
          //   centerTitle: true,
          // ),
          body: SlidableScreenTest()
          // DatePickerTest()
          // WindowTestScreen()
          // VideoTestScreen()
          //RouterApp
          // (TextTest()) //CameraWindows WebSoketScreen SocketIoScreen TestImgSelectScreen ImgMergeTest KeyboardTest KeyboardServiceTest TestTwoScreen TestOneScreen
          // body: FutureBuilder(
          //     future: DBHelper().getAllDogs(),
          //     builder: (BuildContext context, AsyncSnapshot<List<Dog>> snapshot) {
          //       if (snapshot.hasData) {
          //         return ListView.builder(
          //           itemCount: snapshot.data!.length,
          //           itemBuilder: (BuildContext context, int index) {
          //             Dog item = snapshot.data![index];
          //             return Dismissible(
          //               key: UniqueKey(),
          //               onDismissed: (direction) {
          //                 DBHelper().deleteDog(item.id!);
          //                 setState(() {});
          //               },
          //               child: Center(child: Text(item.name!)),
          //             );
          //           },
          //         );
          //       } else {
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //     }),
          // floatingActionButton: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     FloatingActionButton(
          //       child: Icon(Icons.refresh),
          //       onPressed: () {
          //         DBHelper().deleteAllDogs();
          //         setState(() {});
          //       },
          //     ),
          //     SizedBox(height: 8.0),
          //     FloatingActionButton(
          //       child: Icon(Icons.add),
          //       onPressed: () {
          //         Dog dog = dogs[Random().nextInt(dogs.length)];
          //         DBHelper().createData(dog);
          //         setState(() {});
          //       },
          //     ),
          //   ],
          // ),
          ),
    );
  }
}

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({Key? key}) : super(key: key);

  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  int currentPage = 0;
  List<String> pageName = ["First Page", "Second Page", "Third Page"];

  final PageController controller =
      PageController(initialPage: 0, viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: (value) {
        setState(() {
          currentPage = value;
        });
      },
      itemCount: pageName.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.blue.withOpacity(index * 0.1),
          child: Center(
            child: Text(
              pageName[index],
              style: TextStyle(fontSize: 50),
            ),
          ),
        );
      },
    );
  }
}
