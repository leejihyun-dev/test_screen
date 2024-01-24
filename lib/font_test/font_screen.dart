import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;

class FontScreen extends StatefulWidget {
  const FontScreen({super.key});

  @override
  State<FontScreen> createState() => _FontScreenState();
}

class _FontScreenState extends State<FontScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '테스트',
          style: TextStyle(fontSize: 50),
        ),
        Text(
          '테스트',
          style: TextStyle(fontFamily: 'Pretendard', fontSize: 50),
        ),
        Text(
          '테스트',
          style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 50,
              fontWeight: FontWeight.bold),
        ),
        SvgPicture.asset(
          'assets/next_btn_new.svg',
          width: 200,
          height: 200,
          allowDrawingOutsideViewBox: true,
        ),
      ],
    );
  }
}
