import 'dart:io';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";
import 'package:scroll_to_id/scroll_to_id.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

List<History> historys = [
  History(
      date: DateTime.parse('1999-01-01'), content: '사회 공헌 사업 누적 기부금 100 억원 달성'),
  History(date: DateTime.parse('1999-02-01'), content: '강원 도 지사 감사패'),
  History(date: DateTime.parse('1999-02-11'), content: '정신건강검사 서비스 마음검진 도입'),
  History(date: DateTime.parse('1999-03-01'), content: '국가 보훈처 업무 협약 체결'),
  History(date: DateTime.parse('1999-04-01'), content: '대한 민국 대표 브랜드'),
  History(date: DateTime.parse('1999-05-01'), content: '건강 지키미 캐릭터 크미 공개'),
  History(
      date: DateTime.parse('1999-06-01'), content: '한국 표준 협회 소비자 웰빙 환경 만족 지수'),
  History(
      date: DateTime.parse('2000-01-01'), content: '사회 공헌 사업 누적 기부금 100 억원 달성'),
  History(date: DateTime.parse('2000-02-01'), content: '강원 도 지사 감사패'),
  History(date: DateTime.parse('2000-02-11'), content: '정신건강검사 서비스 마음검진 도입'),
  History(date: DateTime.parse('2000-03-01'), content: '국가 보훈처 업무 협약 체결'),
  History(date: DateTime.parse('2000-04-01'), content: '대한 민국 대표 브랜드'),
  History(date: DateTime.parse('2000-05-01'), content: '건강 지키미 캐릭터 크미 공개'),
  History(
      date: DateTime.parse('2000-06-01'), content: '한국 표준 협회 소비자 웰빙 환경 만족 지수'),
];

List<Picture> pictures = [
  Picture(year: 1999, images: [
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
  ]),
  Picture(year: 2000, images: [
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
    'assets/test_data/image17.png',
    'assets/test_data/image23.png',
    'assets/test_data/image24.png',
    'assets/test_data/image25.png',
    'assets/test_data/image26.png',
    'assets/test_data/image27.png',
    'assets/test_data/image30.png',
    'assets/test_data/image60.png',
    'assets/test_data/image61.png',
  ]),
];

class HistoryTest1 extends StatefulWidget {
  const HistoryTest1({super.key});

  @override
  State<HistoryTest1> createState() => _HistoryTest1State();
}

class _HistoryTest1State extends State<HistoryTest1> {
  List<YearHistoryWithPicture> yearHistoryWithPictures = [];
  ScrollController scrollController = ScrollController();
  late ScrollToId scrollToId;
  @override
  void initState() {
    scrollToId = ScrollToId(scrollController: scrollController);

    Map<int, List<History>> groupHistorys =
        groupBy(historys, (history) => history.date.year);
    List<int> yearKeys = groupHistorys.keys.toList();

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

    for (int i = 0; i < yearKeys.length; i++) {
      int year = yearKeys[i];
      List<History> historys = groupHistorys[year]!;
      Picture onYearPictures = pictures.firstWhere(
          (element) => element.year == year,
          orElse: () => Picture(year: 0, images: []));
      YearHistoryWithPicture yearHistoryWithPicture = YearHistoryWithPicture(
          year: year, historys: historys, picture: onYearPictures);
      yearHistoryWithPictures.add(yearHistoryWithPicture);
    }
    print('yearHistoryWithPictures:$yearHistoryWithPictures');

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
            body: Stack(
          children: [
            Container(
              width: 1050,
              height: MediaQuery.of(context).size.height,
              child: InteractiveScrollViewer(
                scrollToId: scrollToId,
                children: yearHistoryWithPictures
                    .map((e) =>
                        item(id: e.year.toString(), yearHistoryWithPicture: e))
                    .toList(),
              ),
            ),
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
    print('id $id');
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
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: 800,
              child: MasonryGridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemCount: yearHistoryWithPicture.picture.images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print(
                          '이미지 선택 ${yearHistoryWithPicture.picture.images[index]}');
                    },
                    child: Image.asset(
                      yearHistoryWithPicture.picture.images[index],
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//연역 1개
class History {
  final DateTime date;
  final String content;

  History({
    required this.date,
    required this.content,
  });
  @override
  String toString() {
    return '\nHistory(date:$date, content:$content)';
  }
}

//이미지 1개
class Picture {
  final int year;
  final List<String> images;

  Picture({
    required this.year,
    required this.images,
  });
  @override
  String toString() {
    return '\nPicture(year:$year, images:$images)';
  }
}

//1년 단위 연역과 이미지 모음
class YearHistoryWithPicture {
  final int year;
  final List<History> historys;
  final Picture picture;

  YearHistoryWithPicture({
    required this.year,
    required this.historys,
    required this.picture,
  });

  @override
  String toString() {
    return '\nYearHistoryWithPicture(year:$year, historys:$historys, picture:$picture)';
  }
}
