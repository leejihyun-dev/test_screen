import 'package:flutter/material.dart';
import 'package:test_screen_change/web_soket_test/web_soket_test.dart';

class TestTwoScreen extends StatefulWidget {
  const TestTwoScreen({super.key});

  @override
  State<TestTwoScreen> createState() => _TestTwoScreenState();
}

class _TestTwoScreenState extends State<TestTwoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.amber.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '컨트롤러',
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => WebSoketScreen(),
                  ),
                );
              },
              child: Text('컨트롤화면 가기'),
            )
          ],
        ),
      ),
    );
  }
}
