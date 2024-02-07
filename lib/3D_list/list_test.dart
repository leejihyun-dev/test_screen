import 'package:flutter/material.dart';

class ListTest extends StatefulWidget {
  const ListTest({super.key});

  @override
  State<ListTest> createState() => _ListTestState();
}

class _ListTestState extends State<ListTest> {
  final colors = [
    Colors.red.shade200,
    Colors.lightBlue.shade200,
    Colors.lightGreen.shade200,
    Colors.purple.shade200,
    Colors.teal.shade200,
    Colors.orange.shade200,
    Colors.red.shade200,
    Colors.lightBlue.shade200,
    Colors.lightGreen.shade200,
    Colors.purple.shade200,
    Colors.teal.shade200,
    Colors.orange.shade200,
  ];
  double x = 0;
  double y = 0;
  double z = 0.002;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.blue,
      child: Column(
        children: [
          Container(
            width: 500,
            color: Colors.amber,
            height: MediaQuery.of(context).size.height,
            // child: ListWheelScrollView(
            //   itemExtent: 100, // 각 항목의 높이
            //   children: List.generate(
            //     10,
            //     (index) => Container(
            //       width: 500,
            //       height: 500,
            //       color: Colors.green,
            //       child: ListTile(
            //         title: Center(
            //           child: Text('Item $index'),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ),
          /*
            1,0,0,0, x,0,0,0, <-x값을 바꾸면 x축방향으로 위젯이 늘어남
            0,1,0,0, 0,y,0,0, <-y값을 바꾸면 y축방향으로 위젯이 늘어남
            0,0,1,0, 0,0,z,0, <-z값을 바꾸면 z축방향으로 위젯이 늘어남
            0,0,0,1, 0,0,0,1, <-x,y,z 모든 방향으로 스크롤링 해주는 자리
          */
          // Transform(
          //   transform: Matrix4(
          //     1,
          //     0,
          //     0,
          //     0,
          //     0,
          //     1,
          //     0,
          //     0,
          //     0,
          //     0,
          //     1,
          //     0,
          //     0,
          //     0,
          //     0,
          //     1,
          //   )
          //     ..rotateX(x)
          //     ..rotateY(y)
          //     ..rotateZ(z),
          //   alignment: FractionalOffset.center,
          //   child: Container(
          //     width: 500,
          //     height: MediaQuery.of(context).size.height,
          //     child: ListView.builder(
          //       itemCount: colors.length,
          //       itemBuilder: (context, index) {
          //         return GestureDetector(
          //           onPanUpdate: (details) {
          //             setState(() {
          //               y = y - details.delta.dx / 100;
          //               x = x + details.delta.dy / 100;
          //             });
          //           },
          //           child: Container(
          //             width: 300,
          //             height: 300,
          //             color: colors[index],
          //             child: Center(
          //               child: Text('Item $index'),
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
      // child: ListWheelScrollView(
      //   itemExtent: 50, // 각 항목의 높이
      //   children: List.generate(
      //     10,
      //     (index) => Container(
      //       width: 500,
      //       height: 500,
      //       color: Colors.green,
      //       child: ListTile(
      //         title: Center(
      //           child: Text('Item $index'),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),

      // ListWheelScrollView.useDelegate(
      //   itemExtent: 75,
      //   diameterRatio: 4,
      //   childDelegate: ListWheelChildBuilderDelegate(
      //     childCount: 100,
      //     builder: (context, index) => Container(
      //       color: Colors.blue,
      //       child: Center(
      //         child: Text('Item $index'),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
