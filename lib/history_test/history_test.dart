import 'dart:io';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";
import 'package:scroll_to_id/scroll_to_id.dart';

List<History> historys = [
  History(
      date: DateTime.parse('1999-01-01'),
      category: '카테고리',
      content: '사회 공헌 사업 누적 기부금 100 억원 달성'),
  History(
      date: DateTime.parse('1999-02-01'),
      category: '카테고리',
      content: '강원 도 지사 감사패'),
  History(
      date: DateTime.parse('1999-02-11'),
      category: '카테고리',
      content: '정신건강검사 서비스 마음검진 도입'),
  History(
      date: DateTime.parse('1999-03-01'),
      category: '카테고리',
      content: '국가 보훈처 업무 협약 체결'),
  History(
      date: DateTime.parse('1999-04-01'),
      category: '카테고리1',
      content: '대한 민국 대표 브랜드'),
  History(
      date: DateTime.parse('1999-05-01'),
      category: '카테고리1',
      content: '건강 지키미 캐릭터 크미 공개'),
  History(
      date: DateTime.parse('1999-06-01'),
      category: '카테고리1',
      content: '한국 표준 협회 소비자 웰빙 환경 만족 지수'),
  History(
      date: DateTime.parse('2000-01-01'),
      category: '카테고리',
      content: '사회 공헌 사업 누적 기부금 100 억원 달성'),
  History(
      date: DateTime.parse('2000-02-01'),
      category: '카테고리',
      content: '강원 도 지사 감사패'),
  History(
      date: DateTime.parse('2000-02-11'),
      category: '카테고리1',
      content: '정신건강검사 서비스 마음검진 도입'),
  History(
      date: DateTime.parse('2000-03-01'),
      category: '카테고리1',
      content: '국가 보훈처 업무 협약 체결'),
  History(
      date: DateTime.parse('2000-04-01'),
      category: '카테고리',
      content: '대한 민국 대표 브랜드'),
  History(
      date: DateTime.parse('2000-05-01'),
      category: '카테고리',
      content: '건강 지키미 캐릭터 크미 공개'),
  History(
      date: DateTime.parse('2000-06-01'),
      category: '카테고리1',
      content: '한국 표준 협회 소비자 웰빙 환경 만족 지수'),
];

List<Picture> pictures = [
  Picture(year: 1999, category: '카테고리', images: [
    'assets/0.png',
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
  ]),
  Picture(year: 2001, category: '카테고리', images: [
    'assets/7.png',
    'assets/8.png',
    'assets/9.png',
    'assets/10.png',
    'assets/11.png',
  ]),
  Picture(year: 2000, category: '카테고리1', images: [
    'assets/7.png',
    'assets/8.png',
    'assets/9.png',
    'assets/10.png',
    'assets/11.png',
  ]),
];

class HistoryTest extends StatefulWidget {
  const HistoryTest({super.key});

  @override
  State<HistoryTest> createState() => _HistoryTestState();
}

class _HistoryTestState extends State<HistoryTest> {
  List<YearHistoryWithPicture> yearHistoryWithPictures = [];
  List<HistoryYear> historyYesrs = [];

  ScrollController scrollController = ScrollController();
  late ScrollToId scrollToId;
  @override
  void initState() {
    scrollToId = ScrollToId(scrollController: scrollController);

    Map<int, List<History>> groupHistorys =
        groupBy(historys, (history) => history.date.year);
    List<int> yearKeys = groupHistorys.keys.toList();
    print('yearKeys $yearKeys');

    Map<String, List<History>> groupCategorys =
        groupBy(historys, (history) => history.category);
    List<String> categoryKeys = groupCategorys.keys.toList();
    print('categoryKeys $categoryKeys'); //카테고리 묶기

/* 만약)
    설명데이터에는 년도가 없고,
    이미지데이터에는 년도가 있는 경우
    이미지데이터에서 년도를 뽑아서 전체 년도를 합치고 오름차순으로 정렬해준다.

    Map<int, List<Picture>> groupImages =
  
        groupBy(pictures, (history) => history.year);

    List<int> yearKeys = groupHistorys.keys.toList();
    List<int> yearImagesKeys = groupImages.keys.toList();

    print('설명 연도모음 $yearKeys');
    print('이미지 연도모음 $yearImagesKeys');

    List<int> allYearKeys = yearKeys;
    allYearKeys.addAll(yearImagesKeys);
    List<int> testKeys = allYearKeys.toSet().toList();
    testKeys.sort();

    print('합친 연도모음 $testKeys');
*/
    for (int i = 0; i < categoryKeys.length; i++) {
      String category = categoryKeys[i];
      List<History> historys = groupCategorys[category]!;
      Picture onYearPictures = pictures.firstWhere(
          (element) => element.category == category,
          orElse: () => Picture(year: 0, category: '', images: []));
      YearHistoryWithPicture yearHistoryWithPicture = YearHistoryWithPicture(
          category: category, historys: historys, picture: onYearPictures);
      yearHistoryWithPictures.add(yearHistoryWithPicture);
    }

    print('합친 연도 $yearHistoryWithPictures');

    for (int i = 0; i < yearKeys.length; i++) {
      for (int j = 0; j < categoryKeys.length; j++) {
        int year = yearKeys[i];
        String category = categoryKeys[j];
        List<History> historys = groupHistorys[year]!;
        List<History> categorys = groupCategorys[category]!;
        print('categorys $categorys');
        HistoryYear historyYesr =
            HistoryYear(category: 'test', year: year, contents: historys);
        historyYesrs.add(historyYesr);
      }
    }
    print(historyYesrs);

    // for (int i = 0; i < yearKeys.length; i++) {
    //   int year = yearKeys[i];
    //   List<History> historys = groupHistorys[year]!;
    //   c = groupCategorys;
    //   Picture onYearPictures = pictures.firstWhere(
    //       (element) => element.year == year,
    //       orElse: () => Picture(year: 0, category: '', images: []));
    //   YearHistoryWithPicture yearHistoryWithPicture = YearHistoryWithPicture(category: ,
    //       year: year, historys: historys, picture: onYearPictures);
    //   yearHistoryWithPictures.add(yearHistoryWithPicture);
    // }
    // print(yearHistoryWithPictures);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: Colors.blue,
            body: Stack(
              children: [
                // InteractiveScrollViewer(
                //   scrollToId: scrollToId,
                //   children: yearHistoryWithPictures
                //       .map((e) => item(
                //           id: e.year.toString(), yearHistoryWithPicture: e))
                //       .toList(),
                // ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          scrollToId.animateTo('1999',
                              duration: Duration(milliseconds: 400),
                              curve: Curves.easeIn);
                        },
                        child: Text('1999'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          scrollToId.animateTo('2000',
                              duration: Duration(milliseconds: 400),
                              curve: Curves.easeIn);
                        },
                        child: Text('2000'),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }

  ScrollContent item(
      {required String id,
      required YearHistoryWithPicture yearHistoryWithPicture}) {
    return ScrollContent(
      id: id,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  id,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                ...yearHistoryWithPicture.historys
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(color: Colors.grey),
                              child: Text(e.content)),
                        ))
                    .toList()
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: yearHistoryWithPicture.picture.images
                  .map(
                    (e) => Container(
                      width: 200,
                      height: 200,
                      child: Image.asset(
                        e,
                        fit: BoxFit.cover,
                      ),
                      // child: Image.file(
                      //   File(e),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

//연역 1개
class History {
  final DateTime date;
  final String category;
  final String content;

  History({
    required this.date,
    required this.category,
    required this.content,
  });
  @override
  String toString() {
    return '\nHistory(date:$date, category:$category, content:$content)';
  }
}

//연역 같은 연도 합쳐
class HistoryYear {
  final int year;
  final String category;
  final List<History> contents;

  HistoryYear({
    required this.year,
    required this.category,
    required this.contents,
  });
  @override
  String toString() {
    return '\nHistoryYear(year:$year, category:$category, content:$contents)';
  }
}

//이미지 1개
class Picture {
  final int year;
  final String category;
  final List<String> images;

  Picture({
    required this.year,
    required this.category,
    required this.images,
  });
  @override
  String toString() {
    return '\nPicture(year:$year, category:$category, images:$images)';
  }
}

//1년 단위 연역과 이미지 모음
class YearHistoryWithPicture {
  final String category;
  // final int year;
  final List<History> historys;
  final Picture picture;

  YearHistoryWithPicture({
    required this.category,
    // required this.year,
    required this.historys,
    required this.picture,
  });

  @override
  String toString() {
    return '\nYearHistoryWithPicture(category:$category, historys:$historys, picture:$picture)'; //year:$year,
  }
}
