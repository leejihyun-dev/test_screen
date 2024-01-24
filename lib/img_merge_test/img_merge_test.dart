import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImgMergeTest extends StatefulWidget {
  const ImgMergeTest({super.key});

  @override
  State<ImgMergeTest> createState() => _ImgMergeTestState();
}

class _ImgMergeTestState extends State<ImgMergeTest> {
  // final imagone = Image.asset('assets/0.png');
  // final imagtwo = Image.asset('assets/1.png');
  final imagone = img.decodeImage(File('assets/0.png').readAsBytesSync());
  final imagtwo = img.decodeImage(File('assets/1.png').readAsBytesSync());
  final imagthree = img.decodeImage(File('assets/2.png').readAsBytesSync());
  final imagfour = img.decodeImage(File('assets/3.png').readAsBytesSync());

  List<img.Image?> overlayImages = List.filled(4, null);
  img.Image? mergedImage;
  img.Image? background;

  @override
  void initState() {
    super.initState();
  }

  void init() async {
    // final mergedImage = img.Image(
    //     width: imagone!.width + imagtwo!.width,
    //     height: imagone!.height + imagtwo!.height);

    // img.compositeImage(imagone!, imagtwo!, dstX: 0, dstY: 0);

    // final documentDirectory = Directory.current; // 현재 디렉토리 가져오기
    // print(mergedImage);
    // final file = File('${documentDirectory.path}/merged_image.jpg');

    // file.writeAsBytesSync(img.encodeJpg(mergedImage));

    // imagone = img.decodeImage(File('assets/0.png').readAsBytesSync());
    // imagtwo = img.decodeImage(File('assets/1.png').readAsBytesSync());

    background =
        img.decodeImage(File('assets/5.png').readAsBytesSync()); // 뒷 프레임

    // 겹칠 이미지들
    for (int i = 0; i < 4; i++) {
      // overlayImages[i] =
      //     img.decodeImage(File('assets/$i.png').readAsBytesSync());
      try {
        overlayImages[i] =
            img.decodeImage(File('assets/$i.png').readAsBytesSync());
      } catch (e) {
        print('Error loading overlay image $i: $e');
      }
    }

    if (background != null && overlayImages.every((image) => image != null)) {
      img.Image resizedBackground = img.copyResize(background!,
          width: 200, //background!.width,
          height: 600); //background!.height); //프레임 사이즈 조절 200x600

      int totalWidth = resizedBackground.width;
      int totalHeight = resizedBackground.height;

      mergedImage = img.Image(width: totalWidth, height: totalHeight);

      // 배경 이미지 복사
      img.compositeImage(mergedImage!, resizedBackground,
          dstX: 0, dstY: 0); //mergedImage에 뒷 프레임을 넣어줌

      // 겹칠 이미지들을 세로로 합치기
      int currentY = 0;
      for (int i = 0; i < overlayImages.length; i++) {
        img.Image resizedOverlay =
            img.copyResize(overlayImages[i]!, width: 250, height: 140);
        print('Overlay Image $i Width: ${overlayImages[i]!.width}');
        print('Overlay Image $i Height: ${overlayImages[i]!.height}');

        // // 0번째 이미지에만 마진을 적용
        // int margin = (i == 0) ? 10 : 0;

        img.compositeImage(mergedImage!, resizedOverlay, //resizedOverlay,
            dstX: 0,
            dstY: currentY + 10);
        currentY += resizedOverlay.height; // 겹치는 이미지의 높이만큼 증가
      }

      setState(() {}); // 이미지가 합쳐진 후 UI 업데이트

      print('Merged Image Width: ${mergedImage!.width}');
      print('Merged Image Height: ${mergedImage!.height}');
      Uint8List pngByte = mergedImage!.getBytes();
      await _saveImageToLocalFile(pngByte);
    }
  }

  Future<String> _saveImageToLocalFile(Uint8List data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}\\composite_image.png');
    await file.writeAsBytes(data);
    print('file.writeAsBytes(data): ${file.writeAsBytes(data)}');

    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                width: 200,
                height: 200,
                color: Colors.indigo,
                // child: imagone,
              ),
              Container(
                width: 200,
                height: 200,
                color: Colors.amber,
                // child: imagtwo,
              ),
            ],
          ),
          SizedBox(
            width: 100,
          ),
          Container(
            width: 200,
            height: 600,
            color: Colors.pink,
            child: mergedImage != null
                ? Image.memory(
                    Uint8List.fromList(img.encodeJpg(mergedImage!)),
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
