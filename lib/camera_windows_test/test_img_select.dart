import 'dart:io';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_screen_change/camera_windows_test/testImg_model.dart';

List<TestImgModel> testImgOne = [
  TestImgModel(imgUrl: 'assets/네컷이미지0.png', selectImg: false, imagType: 'L'),
  TestImgModel(imgUrl: 'assets/네컷이미지1.png', selectImg: false, imagType: 'L'),
  TestImgModel(imgUrl: 'assets/네컷이미지2.png', selectImg: false, imagType: 'L'),
  TestImgModel(imgUrl: 'assets/네컷이미지3.jpeg', selectImg: false, imagType: 'L'),
  TestImgModel(imgUrl: 'assets/5.png', selectImg: false, imagType: 'L'),
  TestImgModel(imgUrl: 'assets/7.png', selectImg: false, imagType: 'L'),
  TestImgModel(imgUrl: 'assets/8.png', selectImg: false, imagType: 'L'),
  TestImgModel(imgUrl: 'assets/9.png', selectImg: false, imagType: 'L'),
];

List<TestImgModel> testImgTwo = [
  TestImgModel(imgUrl: 'assets/one.jpeg', selectImg: false, imagType: 'A'),
  TestImgModel(imgUrl: 'assets/two.jpeg', selectImg: false, imagType: 'A'),
  TestImgModel(imgUrl: 'assets/three.jpeg', selectImg: false, imagType: 'A'),
  TestImgModel(imgUrl: 'assets/four.jpg', selectImg: false, imagType: 'A'),
];

List<String> testImgTwoSave = [
  'assets/one.jpeg',
  'assets/two.jpeg',
  'assets/three.jpeg',
  'assets/four.jpg',
];

final selectPictureIndexProvider = StateProvider.autoDispose<int>((ref) {
  return -1;
});

class TestImgSelectScreen extends ConsumerStatefulWidget {
  const TestImgSelectScreen({super.key});

  @override
  ConsumerState<TestImgSelectScreen> createState() =>
      _TestImgSelectScreenState();
}

class _TestImgSelectScreenState extends ConsumerState<TestImgSelectScreen> {
  int testInt = -1; //테스틍
  List<int> testIntArray = []; //테스트틍
  bool firstClick = false; // 첫 클릭

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void selectImgRemove(index, int pictureIndex) {
    setState(() {
      testImgTwo[index].imgUrl = testImgTwoSave[index];
      testImgTwo[index].imagType = 'A';
      testImgOne[pictureIndex].selectImg = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.blue[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 500,
            height: 700,
            color: Colors.amber,
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2.5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: List.generate(testImgOne.length, (index) {
                return GestureDetector(
                    onTap: () {
                      ref.read(selectPictureIndexProvider.notifier).state =
                          index;

                      setState(() {
                        print('testIMGTWO ${testImgTwo.asMap()}');
                        for (int i = 0; i < testImgTwo.length; i++) {
                          if (testImgTwo[i].imagType != 'L') {
                            testIntArray.add(i); //선택한 사진이 없는 배열만 모아본다.
                          }
                        } //하나 지우고 또 다른 거 지울 경우 다른 빈곳에 사진이 들어감 왜이러냐

                        if (testIntArray.isNotEmpty) {
                          testImgTwo[testIntArray.first].imgUrl =
                              testImgOne[index].imgUrl;
                          testImgTwo[testIntArray.first].imagType = 'L';
                          testIntArray = []; // 배열 초기화

                          //선택한 사진에 테두리 주려고 (선택구분 확인용)
                          testImgOne[index].selectImg =
                              !testImgOne[index].selectImg!;
                        } else {
                          if (testImgOne[index].selectImg == true) {
                            testImgOne[index].selectImg =
                                !testImgOne[index].selectImg!;
                            for (int i = 0; i < testImgTwo.length; i++) {
                              if (testImgTwo[i].imgUrl ==
                                  testImgOne[index].imgUrl) {
                                testImgTwo[i].imgUrl = testImgTwoSave[i];
                                testImgTwo[i].imagType = 'A';
                                print('프레임안 사진 ${testImgTwo[i].toMap()}');
                              }
                            }
                            print('선택한 사진 눌렀을때는? ${testImgOne[index].toMap()}');
                          }
                        }

                        //   if (!firstClick) {
                        //     //첫 클릭이면 무조건 0번째에 넣어준다.
                        //     firstClick = true; // 첫 클릭 구분
                        //     testImgTwo[0].imgUrl = testImgOne[index].imgUrl;
                        //     testImgTwo[0].imagType = 'L';
                        //     testImgOne[index].selectImg =
                        //         !testImgOne[index].selectImg!;
                        //   } else {
                        //     //첫 클릭 이후부터는 ...
                        //     bool anySelected = false;

                        //     for (int i = 0; i < testImgTwo.length; i++) {
                        //       print('testImgTwo?? ${testImgTwo[i].toMap()}');
                        //       if (testImgTwo[i].imagType != 'L') {
                        //         testIntArray.add(i); //선택한 사진이 없는 배열만 모아본다.
                        //       }
                        //     }
                        //     print('testIntArray $testIntArray');

                        //     if (testIntArray.isEmpty) {
                        //       print('어딜 타는거임1');
                        //       //프레임 사진 다 선택했을 경우
                        //       if (testImgOne[index].selectImg!) {
                        //         print('testImgOne ${testImgOne[index].imgUrl}');
                        //         //선택했던 이미지 클릭시 다시 뺀다.
                        //         for (int i = 0; i < testImgTwo.length; i++) {
                        //           print(
                        //               'testImgTwo ${testImgTwo[i].imgUrl} testImgOne ${testImgOne[index].imgUrl}');
                        //           if (testImgTwo[i].imgUrl ==
                        //               testImgOne[index].imgUrl) {
                        //             //들어있는 사진 중에 url 같은 것 찾아서
                        //             //그 인덱스 imgurl을 testImgTwoSave 값으로 바꿔준다.
                        //             testImgTwo[i].imgUrl = testImgTwoSave[i];
                        //             // testImgTwo[i].imagType = 'A';
                        //           }
                        //         }
                        //         testImgOne[index].selectImg =
                        //             !testImgOne[index].selectImg!;
                        //       } else {
                        //         print('어딜 타는거임2');
                        //         // testImgTwo[0].imgUrl = testImgOne[index].imgUrl;
                        //         // testImgTwo[0].imagType = 'L';
                        //         //만일 선택했던 사진들을 다 취소했다면
                        //         for (int j = 0; j < testImgOne.length; j++) {
                        //           if (testImgOne[j].selectImg == true) {
                        //             print('tlqkf ${testImgOne[j]}');
                        //             anySelected = true;
                        //             break;
                        //           }
                        //         }

                        //         if (!anySelected) {
                        //           print('tlqkf');
                        //           testImgTwo[0].imgUrl = testImgOne[index].imgUrl;
                        //           testImgTwo[0].imagType = 'L';
                        //         }
                        //         testImgOne[index].selectImg =
                        //             !testImgOne[index].selectImg!;
                        //       }
                        //     } else {
                        //       //선택한 사진이 없는 배열의 첫번째부터 다시 넣어줘야해서~~
                        //       print('어딜 타는거임3');
                        //       testImgTwo[testIntArray.first].imgUrl =
                        //           testImgOne[index].imgUrl;
                        //       testImgTwo[testIntArray.first].imagType = 'L';
                        //       testIntArray = []; // 배열 초기화

                        //       //선택한 사진에 테두리 주려고 (선택구분 확인용)
                        //       testImgOne[index].selectImg =
                        //           !testImgOne[index].selectImg!;
                        //     }
                        //   }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 5,
                              color: testImgOne[index].selectImg == true
                                  ? Colors.white
                                  : Colors.transparent)),
                      child: Image.file(File(testImgOne[index].imgUrl!)),
                    ));
              }),
            ),
          ),
          SizedBox(
            width: 50,
          ),
          Container(
            width: 500,
            height: 700,
            color: Colors.red,
            child: Column(
              children: testImgTwo.mapIndexed((index, element) {
                return ImageContainer(
                  index: index,
                  imag: testImgTwo[index].imgUrl!,
                  imagType: testImgTwo[index].imagType!,
                  selectImgRemove: selectImgRemove,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageContainer extends ConsumerStatefulWidget {
  final int index;
  final String imag;
  final String imagType;
  final Function(int index, int pictureIndex) selectImgRemove;

  const ImageContainer({
    super.key,
    required this.index,
    required this.imag,
    required this.imagType,
    required this.selectImgRemove,
  });

  @override
  ConsumerState<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends ConsumerState<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    final selectPictureIndex = ref.watch(selectPictureIndexProvider);

    return GestureDetector(
      onTap: () {
        print('click ${widget.index}');
        widget.selectImgRemove(widget.index, selectPictureIndex);
      },
      child: Container(
        width: 200,
        height: 150,
        child: widget.imagType == 'L'
            ? Image.asset(
                widget.imag,
                fit: BoxFit.cover,
              )
            : Image.asset(
                widget.imag,
                fit: BoxFit.cover,
              ),
        margin: EdgeInsets.only(top: 20),
      ),
    );
  }
}
