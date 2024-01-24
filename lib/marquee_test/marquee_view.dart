import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MarqueeScreen extends StatefulWidget {
  const MarqueeScreen({super.key});

  @override
  State<MarqueeScreen> createState() => _MarqueeScreenState();
}

class _MarqueeScreenState extends State<MarqueeScreen> {
  Timer? timer;
  final double _height = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Dobby Free'),
          SizedBox(
            height: _height,
            child: Marquee(
              text: '안녕하세요',
              //blankSpace: _height, //위로 올라갈 때는 sizedBox의 높이만큼 준다.
              //blankSpace: MediaQuery.of(context).size.width, //자막간 칸 띄우기
              //scrollAxis: Axis.values(),
              //velocity: 음수를 주면 거꾸로 돌아간다,
              scrollAxis: Axis.vertical,
              // scrollAxis:
              //     Axis.vertical, //위로 올라가기: vertical, 옆으로 지나가기: horizontal
            ),
          ),
        ],
      ),
    );
  }
}
