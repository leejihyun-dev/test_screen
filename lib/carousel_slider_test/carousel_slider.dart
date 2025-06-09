// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class CarouselSliderTest extends StatefulWidget {
//   const CarouselSliderTest({super.key});

//   @override
//   State<CarouselSliderTest> createState() => _CarouselSliderTestState();
// }

// final testImg = [
//   'assets/0.png',
//   'assets/1.png',
//   // 'assets/2.png',
// ];
// final inteval = [
//   1,
//   5,
//   // 10,
// ];

// class _CarouselSliderTestState extends State<CarouselSliderTest> {
//   int currentPage = 0;
//   int _dynamicInteval = inteval[0];
//   // final CarouselController _carouselController = CarouselController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('build-------------------- $_dynamicInteval');

//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       color: Colors.blue,
//       child: Column(
//         children: [
//           Container(
//             width: 500,
//             height: 500,
//             color: Colors.amber,
//             child: CarouselSlider.builder(
//               carouselController: _carouselController,
//               itemCount: testImg.length,
//               itemBuilder:
//                   (BuildContext context, int itemIndex, int pageViewIndex) {
//                 return Image.asset(testImg[itemIndex]);
//               },
//               options: CarouselOptions(
//                 onPageChanged: (index, reason) {
//                   setState(() {
//                     currentPage = index;
//                     _dynamicInteval = inteval[index];
//                   });

//                   //이 코드가 있어야 autoPlayInterval 시간이 동적으로 먹힌다.; 이유가 뭐람..
//                   if (testImg.length == 2) {
//                     //2개일 경우에 넘어가는게 부자연스러워서 추가
//                     if (index == testImg.length - 1) {
//                       _carouselController.animateToPage(currentPage);
//                     } else {
//                       //마지막 인덱스인 경우 어쩔 수 없이
//                       _carouselController.jumpToPage(currentPage);
//                     }
//                   } else {
//                     _carouselController.animateToPage(currentPage);
//                   }
//                 },
//                 height: MediaQuery.of(context).size.height / 1.26,
//                 autoPlay: true, //자동재생 여부
//                 autoPlayInterval: Duration(seconds: _dynamicInteval), //시간 설정 가능
//                 viewportFraction: 1.0, //화면 채우는 비율
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
