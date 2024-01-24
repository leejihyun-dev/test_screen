import 'package:flutter/material.dart';

class PaddingScreen extends StatefulWidget {
  const PaddingScreen({super.key});

  @override
  State<PaddingScreen> createState() => _PaddingScreenState();
}

class _PaddingScreenState extends State<PaddingScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() {
      // print out the scroll offset
      print(_controller.offset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 800,
            height: 700,
            color: Colors.pink,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                mainAxisSpacing: 10, //수평 Padding
                crossAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
