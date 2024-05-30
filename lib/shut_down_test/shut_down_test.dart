import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

class ShutDownTest extends StatefulWidget {
  const ShutDownTest({super.key});

  @override
  State<ShutDownTest> createState() => _ShutDownTestState();
}

class _ShutDownTestState extends State<ShutDownTest> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      exit(0);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Text(
            '셧다운 테스트',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
