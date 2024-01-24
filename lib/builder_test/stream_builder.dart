import 'dart:math';

import 'package:flutter/material.dart';

class StreamBuilderScreen extends StatefulWidget {
  const StreamBuilderScreen({super.key});

  @override
  State<StreamBuilderScreen> createState() => _StreamBuilderScreenState();
}

class _StreamBuilderScreenState extends State<StreamBuilderScreen> {
  final textStyle = TextStyle(fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<int>(
            //둘 다 제너릭을 지정할 수 있다.
            stream: streamNumbers(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Stream Builder',
                    style: textStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    'constate: ${snapshot.connectionState}',
                    style: textStyle,
                  ),
                  Text(
                    'Data: ${snapshot.data}',
                    style: textStyle,
                  ),
                  Text(
                    'Error: ${snapshot.error}',
                    style: textStyle,
                  )
                ],
              );
            }),
      ),
    );
  }

  Stream<int> streamNumbers() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 1));

      yield i;
    }
  }
}
