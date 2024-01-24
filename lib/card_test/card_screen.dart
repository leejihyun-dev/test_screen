import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;
import 'dart:ui';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final List<Map<String, dynamic>> testData = [
    {'title': 'test1', 'url': 'assets/0.png'},
    {'title': 'test2', 'url': 'assets/1.png'},
    {'title': 'test3', 'url': 'assets/2.png'},
    {'title': 'test4', 'url': 'assets/3.png'},
    {'title': 'test5', 'url': 'assets/4.png'},
    {'title': 'test6', 'url': 'assets/5.png'},
    {'title': 'test7', 'url': 'assets/7.png'},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          children: [
            Image.asset('assets/test.png'),
            // Image.asset('assets/test2.png'),
            // Image.asset('assets/test3.png'),
            //Image.asset('assets/test5.png'),// 빼먹은 프레임 있어서 다시 새로 추출한 버전
            Image.asset('assets/전국센터.png'),
          ],
        ),
        // child: Column(children: [Text('테스트')]),
      ),
    );
    // return ListView.separated(
    //   scrollDirection: Axis.horizontal,
    //   separatorBuilder: (context, index) {
    //     return Divider();
    //   },
    //   itemCount: testData.length,
    //   itemBuilder: (context, index) {
    //     return Card(
    //       child: Column(
    //         children: [
    //           Image.asset(testData[index]['url']),
    //           Text('${testData[index]['title']}')
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
