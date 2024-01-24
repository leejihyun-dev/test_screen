import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class KeyboardTest extends StatefulWidget {
  const KeyboardTest({super.key});

  @override
  State<KeyboardTest> createState() => _KeyboardTestState();
}

class _KeyboardTestState extends State<KeyboardTest> {
  late final TextEditingController _controller;
  List numberArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  List textArrayOne = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'];
  List textArrayTwo = ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'];
  List textArrayThree = ['z', 'x', 'c', 'v', 'b', 'n', 'm'];
  List spacebarArray = [',' 'spacebar', '.'];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void textSave(data) {
    String currentText = _controller.text;
    _controller.text = currentText + data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.blue[50],
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: TextField(
                    controller: _controller,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  label: Text(''),
                )
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.yellow,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: numberArray.mapIndexed((index, element) {
                          return NumberContainer(
                            index: index,
                            label: numberArray[index],
                            textSave: textSave,
                          );
                        }).toList(),
                      ),
                    ),
                  ), //숫자
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: textArrayOne.mapIndexed((index, element) {
                            return TextContainer(
                              index: index,
                              label: textArrayOne[index],
                              textSave: textSave,
                            );
                          }).toList(),
                        )),
                  ), //텍스트
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      color: Colors.pink,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: textArrayTwo.mapIndexed((index, element) {
                          return TextContainer(
                            index: index,
                            label: textArrayTwo[index],
                            textSave: textSave,
                          );
                        }).toList(),
                      ),
                    ),
                  ), //텍스트
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      color: Colors.grey,
                      child: Row(
                        children: [
                          Container(
                            width: 170,
                            height: 90,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_upward_rounded),
                              label: Text(''),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Row(
                            children:
                                textArrayThree.mapIndexed((index, element) {
                              return TextContainer(
                                index: index,
                                label: textArrayThree[index],
                                type: 'Last',
                                textSave: textSave,
                              );
                            }).toList(),
                          ),
                          Container(
                            width: 130,
                            height: 90,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_back),
                              label: Text(''),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), //텍스트
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 130,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[100],
                            ),
                            child: Center(
                              child: Text(
                                ',',
                                style: TextStyle(fontSize: 35),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Container(
                            width: 570,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Container(
                            width: 130,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[100],
                            ),
                            child: Center(
                              child: Text(
                                '.',
                                style: TextStyle(fontSize: 35),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            width: 130,
                            height: 90,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.check),
                              label: Text(''),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), //엔터버튼x, 특수기호x, 이모지x,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NumberContainer extends StatefulWidget {
  //숫자키패드
  final int index;
  final int label;
  final Function(String data) textSave;
  const NumberContainer({
    super.key,
    required this.index,
    required this.label,
    required this.textSave,
  });

  @override
  State<NumberContainer> createState() => _NumberContainerState();
}

class _NumberContainerState extends State<NumberContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 145,
        height: 90,
        margin: EdgeInsets.only(right: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Center(
            child: Text(
          '${widget.label}',
          style: TextStyle(fontSize: 35),
        )),
      ),
    );
  }
}

class TextContainer extends StatefulWidget {
  //텍스트
  final int index;
  final String label;
  final String? type;
  final Function(String data) textSave;
  const TextContainer({
    super.key,
    required this.index,
    required this.label,
    this.type,
    required this.textSave,
  });

  @override
  State<TextContainer> createState() => _TextContainerState();
}

class _TextContainerState extends State<TextContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.textSave(widget.label);
      },
      child: Container(
        width: 130,
        height: 90,
        margin: EdgeInsets.only(right: 'Last' == widget.type ? 34 : 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Center(
            child: Text(
          widget.label,
          style: TextStyle(fontSize: 35),
        )),
      ),
    );
  }
}
