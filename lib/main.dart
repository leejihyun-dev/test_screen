import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:test_screen_change/3D_list/list_test.dart';
import 'package:test_screen_change/animation_test/animation_test.dart';
import 'package:test_screen_change/builder_test/future_builder.dart';
import 'package:test_screen_change/camera_windows_test/camera_windows.dart';
import 'package:test_screen_change/camera_windows_test/test_img_select.dart';
import 'package:test_screen_change/card_test/card_screen.dart';
import 'package:test_screen_change/carousel_slider_test/carousel_slider.dart';
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
import 'package:test_screen_change/sqlite_test/db_helper.dart';
import 'package:test_screen_change/sqlite_test/model/dog_model.dart';
import 'package:test_screen_change/sqlite_test/sqlite_screen.dart';
import 'package:test_screen_change/text_change_animation_test/text_change_screen.dart';
import 'package:test_screen_change/timer_periodic_test/timer_periodic.dart';
import 'package:test_screen_change/video_Test/video_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_screen_change/web_soket_test/socket_io_test.dart';
import 'package:test_screen_change/web_soket_test/test_one_screen.dart';
import 'package:test_screen_change/web_soket_test/test_two_screen.dart';
import 'package:test_screen_change/web_soket_test/web_soket_test.dart';
import 'package:test_screen_change/web_view/web_view.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  //runApp(const MyApp());
  // DartVLC.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
  // runApp(HistoryTest1());
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
      home: Scaffold(
          // appBar: AppBar(
          //   title: Text('3D 목록 테스트 해보기'),
          //   centerTitle: true,
          // ),
          body: //RouterApp
              (TestOneScreen()) //CameraWindows WebSoketScreen SocketIoScreen TestImgSelectScreen ImgMergeTest KeyboardTest KeyboardServiceTest TestTwoScreen TestOneScreen
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
