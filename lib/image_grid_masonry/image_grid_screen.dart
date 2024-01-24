import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ImageGridScreen extends StatefulWidget {
  const ImageGridScreen({super.key});

  @override
  State<ImageGridScreen> createState() => _ImageGridScreenState();
}

class _ImageGridScreenState extends State<ImageGridScreen> {
  ScrollController _scrollController = ScrollController();

  Timer? _debounce;
  String _direction = 'up';

  List<String> widgetHeights = [
    'assets/test_data/image12.png',
    'assets/test_data/image13.png',
    'assets/test_data/image14.png',
    'assets/test_data/image15.png',
    'assets/test_data/image16.png',
    'assets/test_data/image17.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image12.png',
    'assets/test_data/image13.png',
    'assets/test_data/image14.png',
    'assets/test_data/image15.png',
    'assets/test_data/image16.png',
    'assets/test_data/image17.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image16.png',
    'assets/test_data/image17.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image12.png',
    'assets/test_data/image13.png',
    'assets/test_data/image14.png',
    'assets/test_data/image15.png',
    'assets/test_data/image16.png',
    'assets/test_data/image17.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image12.png',
    'assets/test_data/image13.png',
    'assets/test_data/image14.png',
    'assets/test_data/image15.png',
    'assets/test_data/image16.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image12.png',
    'assets/test_data/image13.png',
    'assets/test_data/image14.png',
    'assets/test_data/image15.png',
    'assets/test_data/image16.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image12.png',
    'assets/test_data/image13.png',
    'assets/test_data/image14.png',
    'assets/test_data/image15.png',
    'assets/test_data/image16.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image12.png',
    'assets/test_data/image13.png',
    'assets/test_data/image14.png',
    'assets/test_data/image15.png',
    'assets/test_data/image16.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image12.png',
    'assets/test_data/image13.png',
    'assets/test_data/image14.png',
    'assets/test_data/image15.png',
    'assets/test_data/image16.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image12.png',
    'assets/test_data/image13.png',
    'assets/test_data/image14.png',
    'assets/test_data/image15.png',
    'assets/test_data/image16.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image12.png',
    'assets/test_data/image13.png',
    'assets/test_data/image14.png',
    'assets/test_data/image15.png',
    'assets/test_data/image16.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image12.png',
    'assets/test_data/image13.png',
    'assets/test_data/image14.png',
    'assets/test_data/image15.png',
    'assets/test_data/image16.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image12.png',
    'assets/test_data/image13.png',
    'assets/test_data/image14.png',
    'assets/test_data/image15.png',
    'assets/test_data/image16.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image12.png',
    'assets/test_data/image13.png',
    'assets/test_data/image14.png',
    'assets/test_data/image15.png',
    'assets/test_data/image16.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image12.png',
    'assets/test_data/image13.png',
    'assets/test_data/image14.png',
    'assets/test_data/image15.png',
    'assets/test_data/image16.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
    'assets/test_data/image12.png',
    'assets/test_data/image13.png',
    'assets/test_data/image14.png',
    'assets/test_data/image15.png',
    'assets/test_data/image16.png',
    'assets/test_data/image17.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
  ];
  List<double> widgetColors = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(seconds: 2));
      _direction = 'up';
      //_scrollToUp();

      // _scrollController.addListener(() {
      //   print(
      //       'offset:${_scrollController.offset} minScrollExtent:${_scrollController.position.minScrollExtent} maxScrollExtent:${_scrollController.position.maxScrollExtent}');
      //   if (_scrollController.hasClients &&
      //       _scrollController.offset ==
      //           _scrollController.position.maxScrollExtent) {
      //     if (_debounce?.isActive ?? false) _debounce?.cancel();
      //     _debounce = Timer(const Duration(seconds: 2), () {
      //       _direction = 'up';
      //       _scrollToUp();
      //     });
      //   }
      //   if (_scrollController.hasClients &&
      //       _scrollController.offset ==
      //           _scrollController.position.minScrollExtent) {
      //     _debounce = Timer(const Duration(seconds: 5), () {
      //       _direction = 'right';
      //       _scrollToRight();
      //     });
      //   }
      // });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // void _scrollToUp() async {
  //   await Future.delayed(Duration(milliseconds: 2000));
  //   _scrollController.animateTo(_scrollController.position.maxScrollExtent,
  //       duration: Duration(
  //           seconds: ((_scrollController.position.maxScrollExtent -
  //                       _scrollController.position.pixels) /
  //                   50)
  //               .toInt()),
  //       curve: Curves.linear);
  // }

  @override
  Widget build(BuildContext context) {
    print('widgetHeights ${widgetHeights.length}');
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.blue,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       width: 800,
          //       height: MediaQuery.of(context).size.height,
          //       child: MasonryGridView.count(
          //         padding: EdgeInsets.all(8),
          //         crossAxisCount: 3,
          //         mainAxisSpacing: 8,
          //         crossAxisSpacing: 5,
          //         itemCount: widgetHeights.length,
          //         itemBuilder: (context, index) {
          //           return BackdropFilter(
          //             filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          //             child: Image.asset(
          //               widgetHeights[index],
          //               fit: BoxFit.contain,
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 700,
                height: MediaQuery.of(context).size.height,
                child: Listener(
                  onPointerDown: (event) {},
                  onPointerUp: (event) async {
                    if (_debounce?.isActive ?? false) _debounce?.cancel();
                    _debounce = Timer(const Duration(seconds: 3), () {
                      if (_direction == 'up') {
                        //_scrollToUp();
                      }
                    });
                  },
                  child: NotificationListener(
                    child: MasonryGridView.count(
                      controller: _scrollController,
                      padding: EdgeInsets.all(8),
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 40,
                      itemCount: widgetHeights.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            print('이미지 선택 ${widgetHeights[index]}');
                          },
                          child: Image.asset(
                            widgetHeights[index],
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification) {
                        print('scroll end');

                        if (_direction == 'up') {
                          // _scrollToUp();
                        }
                      }
                      if (notification is ScrollStartNotification) {
                        print('scroll start');
                      }
                      return true;
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              right: 20,
              top: 20,
              child: TimeLaps(
                key: UniqueKey(),
              ))
        ],
      ),
    );
  }
}

class TimeLaps extends StatefulWidget {
  const TimeLaps({super.key});

  @override
  State<TimeLaps> createState() => _TimeLapsState();
}

class _TimeLapsState extends State<TimeLaps> {
  Timer? secondTimer;
  int time = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    time = 0;
    secondTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (time == 20) {
          time = 0;
        } else {
          time++;
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (secondTimer != null) {
      secondTimer!.cancel();
      secondTimer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.2),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        CircularProgressIndicator(
          strokeWidth: 2,
          backgroundColor: Color(0xFFCCCCCC).withOpacity(0),
          color: Colors.white,
          value: time / 20,
        ),
        Text(
          '$time',
          style: TextStyle(color: Colors.white, fontSize: 16),
        )
      ],
    );
  }
}
