import 'package:flutter/material.dart';

class TextTest extends StatefulWidget {
  const TextTest({super.key});

  @override
  State<TextTest> createState() => _TextTestState();
}

class _TextTestState extends State<TextTest> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.green,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.green,
                      ),
                      hintText: '제목을 입력해 주세요.',
                    ),
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: new ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: screen.height,
                      ),
                      child: TextField(
                        controller: _contentController,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                            color: Colors.green,
                          ),
                          hintText: '여러분의 이야기를 나눠보세요.',
                        ),
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.green,
                  width: 2.0,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  color: Colors.blue,
                ),
                Container(
                  width: 10,
                  height: 10,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
