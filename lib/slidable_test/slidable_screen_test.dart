import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class SlidableScreenTest extends StatefulWidget {
  const SlidableScreenTest({super.key});

  @override
  State<SlidableScreenTest> createState() => _SlidableScreenTestState();
}

class _SlidableScreenTestState extends State<SlidableScreenTest> {
  DateTime selectedDate = DateTime.now();

  void showDatePicker() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Container(
          // color: Colors.white,
          height: 300,
          child: CupertinoDatePicker(
            /// Date 수정 시 동작하는 콜백 메서드
            onDateTimeChanged: (DateTime value) {
              setState(() {
                selectedDate = value;
              });
            },

            /// 화면에 뜨는 Date 모드 변경
            mode: CupertinoDatePickerMode.date,

            /// 최대 날짜 지정
            maximumDate: DateTime.now(),

            /// 처음 뜨는 Date 날짜 지정
            initialDateTime: selectedDate,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('확인'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blue, width: 2)),
            child: Slidable(
              key: const ValueKey(0),
              endActionPane:
                  ActionPane(motion: const ScrollMotion(), children: [
                SlidableAction(
                  onPressed: (context) {},
                  flex: 2,
                  backgroundColor: Colors.black,
                  icon: Icons.archive,
                  label: 'archive',
                ),
                SlidableAction(
                  onPressed: (context) {},
                  flex: 1,
                  backgroundColor: Colors.green,
                  icon: Icons.save,
                  label: 'save',
                )
              ]),
              child: const ListTile(
                title: Text('slide me'),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showDatePicker();
            },
            child: Container(
                height: 100,
                color: Colors.blue,
                child: Center(child: Text('날짜 선택 $selectedDate'))),
          ),
        ],
      ),
    );
  }
}
