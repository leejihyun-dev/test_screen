import 'package:flutter/material.dart';

class TextChangeScreen extends StatefulWidget {
  const TextChangeScreen({super.key});

  @override
  State<TextChangeScreen> createState() => _TextChangeScreenState();
}

class _TextChangeScreenState extends State<TextChangeScreen> {
  bool selected = false;
  AlignmentGeometry _alignment = Alignment.bottomCenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        width: 500,
        height: 500,
        color: Colors.amber,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                color: Colors.pink,
                child: AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  // style: TextStyle(
                  //   fontSize: 50.0,
                  //   fontWeight: selected ? FontWeight.w100 : FontWeight.bold,
                  // ),
                  child: Text(
                    '의료연구',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: AnimatedAlign(
                  alignment: _alignment == Alignment.topCenter
                      ? Alignment.topCenter
                      : Alignment.bottomCenter,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  child: Text(
                    'Medical',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      //selected = !selected;
                      _alignment = _alignment == Alignment.bottomCenter
                          ? Alignment.topCenter
                          : Alignment.bottomCenter;
                    });
                    print('alignment $_alignment');
                  },
                  child: Text('change'))
            ],
          ),
        ),
      ),
    );
  }
}
