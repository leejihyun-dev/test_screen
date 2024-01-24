import 'dart:io';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_screen_change/camera_windows_test/testImg_model.dart';

final selectColorProvider = StateProvider<Color>((ref) {
  return Colors.black;
});
final selectFrameProvider = StateProvider<bool>((ref) {
  return false;
});

class PictureSelect extends ConsumerStatefulWidget {
  final List<TestImgModel> pictureList;
  const PictureSelect({super.key, required this.pictureList});

  @override
  ConsumerState<PictureSelect> createState() => _PictureSelectState();
}

class _PictureSelectState extends ConsumerState<PictureSelect> {
  List<TestImgModel> testImg = [
    TestImgModel(imgUrl: 'assets/one.jpeg', selectImg: false, imagType: 'A'),
    TestImgModel(imgUrl: 'assets/two.jpeg', selectImg: false, imagType: 'A'),
    TestImgModel(imgUrl: 'assets/three.jpeg', selectImg: false, imagType: 'A'),
    TestImgModel(imgUrl: 'assets/four.jpg', selectImg: false, imagType: 'A'),
  ];
  List<Color> selectColors = [
    Colors.black,
    Colors.pink,
    Colors.blue,
    Colors.green,
  ];
  bool selectImag = false; // 이미지 선택하기 시작했다면

  @override
  Widget build(BuildContext context) {
    final selectColor = ref.watch(selectColorProvider);
    final selectFrame = ref.watch(selectFrameProvider);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.lime,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              '사진 선택하자~',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 700,
                  height: 600,
                  color: Colors.blue[200],
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2.5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: List.generate(widget.pictureList.length, (index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              //선택한 사진이 프레임에 들어가게 함
                              print('index? $index');
                              for (int i = 0; i < testImg.length; i++) {
                                if ('L' == testImg[i].imagType) {
                                  testImg[i++].imgUrl =
                                      widget.pictureList[index].imgUrl;
                                  testImg[i++].imagType = 'L';
                                  // break;
                                } else {
                                  testImg[i].imgUrl =
                                      widget.pictureList[index].imgUrl;
                                  testImg[i].imagType = 'L';
                                  break;
                                }
                              }

                              //프레임사진 0번에 있는 imagType이 L일 경우 1번에 넣어준다.
                              //프레임사진 1번에 있는 imagType이 L일 경우 2번에 넣어준다.
                              //프레임사진 2번에 있는 imagType이 L일 경우 3번에 넣어준다.

                              //프레임사진 0번을 클릭했을 때 testImg[0]의 imgUrl을 기존꺼로 바꾸고 imagType을 'A'로 변경
                              //프레임사진 0번에 들어있던 url이랑 선택사진 url과 비교해서 맞으면 선택표시도 없애줘야함

                              // testImg[index].imgUrl =
                              //     widget.pictureList[index].imgUrl;
                              // testImg[index].imagType = 'L';

                              widget.pictureList[index].selectImg =
                                  !widget.pictureList[index].selectImg!;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 3,
                                    color:
                                        widget.pictureList[index].selectImg ==
                                                true
                                            ? Colors.white
                                            : Colors.transparent)),
                            // child: ShaderMask(
                            //   shaderCallback: (Rect bounds) {
                            //     return LinearGradient(
                            //       begin: Alignment.topCenter,
                            //       end: Alignment.bottomCenter,
                            //       colors: [Colors.white38, Colors.transparent],
                            //       stops: [0.5, 1.0],
                            //     ).createShader(bounds);
                            //   },
                            //   blendMode: BlendMode.overlay,
                            //   child: Image.file(
                            //     File(widget.pictureList[index].imgUrl!),
                            //   ),
                            // ),
                            child: Image.file(
                              File(widget.pictureList[index].imgUrl!),
                            ),
                            // child: ColorFiltered(
                            //   colorFilter: ColorFilter.mode(Colors.brown,
                            //       BlendMode.color), //color hardLight
                            //   child: Image.file(
                            //       File(widget.pictureList[index].imgUrl!)),
                            // ),
                          ));
                    }),
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                Container(
                  width: 200,
                  height: 600,
                  color: selectFrame ? Colors.transparent : selectColor,
                  child: Stack(
                    children: [
                      Visibility(
                        visible: selectFrame,
                        child: Positioned.fill(
                          child: Image.asset(
                            'assets/frame_test_three.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Column(
                              children: testImg.mapIndexed((index, element) {
                                return ImageContainer(
                                  index: index,
                                  imag: testImg[index].imgUrl!,
                                  imagType: testImg[index].imagType!,
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Text(
                              '한국전기안전공사',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                Container(
                  width: 250,
                  height: 600,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: selectColors.mapIndexed((index, element) {
                      return SelectCircle(
                        index: index,
                        colors: selectColors[index],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 30),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(Icons.arrow_back_rounded),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, right: 30),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(Icons.navigate_next_rounded),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ImageContainer extends StatefulWidget {
  final int index;
  final String imag;
  final String imagType;
  const ImageContainer({
    super.key,
    required this.index,
    required this.imag,
    required this.imagType,
  });

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 120,
      child: widget.imagType == 'L'
          ? Image.file(
              File(widget.imag),
              fit: BoxFit.cover,
            )
          : Image.asset(
              widget.imag,
              fit: BoxFit.cover,
            ),
      margin: EdgeInsets.only(top: 20),
    );
  }
}

class SelectCircle extends ConsumerStatefulWidget {
  final int index;
  final Color colors;
  const SelectCircle({
    super.key,
    required this.index,
    required this.colors,
  });

  @override
  ConsumerState<SelectCircle> createState() => _SelectCircleState();
}

class _SelectCircleState extends ConsumerState<SelectCircle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          print('click?');
          ref.read(selectColorProvider.notifier).state = widget.colors;
          if (Colors.pink == widget.colors) {
            ref.read(selectFrameProvider.notifier).state = true;
          } else {
            ref.read(selectFrameProvider.notifier).state = false;
          }
        });
      },
      child: Colors.pink == widget.colors
          ? Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/frame_test_three.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(top: 0 == widget.index ? 0 : 30),
              decoration: BoxDecoration(
                color: widget.colors,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
    );
  }
}
