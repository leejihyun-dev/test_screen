import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_screen_change/datepicker/date_pick_test.dart';
import 'package:test_screen_change/datepicker/graph_test.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

class DatePickerTest extends StatefulWidget {
  const DatePickerTest({super.key});

  @override
  State<DatePickerTest> createState() => _DatePickerTestState();
}

class _DatePickerTestState extends State<DatePickerTest> {
  DateTime dateTime = DateTime.now();
  DateTime time = DateTime.now();
  List<String> timeone = ['오전', '오후'];
  final FixedExtentScrollController _controller = FixedExtentScrollController();
  int selectedIndexs = 0;
  int hourIndex = 1;
  int minuteIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return TimePickerSpinner(
                      locale: const Locale('en', ''),
                      time: dateTime,
                      is24HourMode: true,
                      isShowSeconds: false,
                      itemHeight: 80,
                      normalTextStyle: const TextStyle(
                        fontSize: 24,
                      ),
                      highlightedTextStyle:
                          const TextStyle(fontSize: 24, color: Colors.blue),
                      isForce2Digits: true,
                      onTimeChange: (time) {
                        setState(() {
                          dateTime = time;
                        });
                      },
                    );
                  });
            },
            child: Text('cupertino timerpicker'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 220,
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      padding: const EdgeInsets.only(top: 8.0),
                      color: Colors.white,
                      child: CupertinoDatePicker(
                        initialDateTime: time,
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: true,
                        // This is called when the user changes the time.
                        onDateTimeChanged: (DateTime newTime) {
                          setState(() => time = newTime);
                        },
                      ),
                    );
                  });
            },
            child: const Text("Pick time"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                showBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    builder: (_) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter bottomState) {
                        return SizedBox(
                          height: 200,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Color(0XFF555555)
                                        .withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 200,
                                  height: 150,
                                  // color: Colors.pink,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        //오전,오후
                                        child: ListWheelScrollView.useDelegate(
                                            controller: _controller,
                                            itemExtent: 50.0,
                                            diameterRatio: 1.5,
                                            perspective: 0.005,
                                            onSelectedItemChanged: (value) {
                                              bottomState(() {
                                                setState(() {
                                                  selectedIndexs = value;
                                                });
                                              });
                                            },
                                            childDelegate:
                                                ListWheelChildBuilderDelegate(
                                                    childCount: timeone.length,
                                                    builder: (context, index) {
                                                      if (index >= 0 &&
                                                          index <
                                                              timeone.length) {
                                                        return Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            timeone[index],
                                                          ),
                                                        );
                                                      }
                                                      return null;
                                                    })),
                                      ),
                                      Expanded(
                                        //시간
                                        child: ListWheelScrollView(
                                          controller: _controller,
                                          itemExtent: 50.0,
                                          diameterRatio: 1.5,
                                          perspective: 0.005,
                                          onSelectedItemChanged: (value) {
                                            bottomState(() {
                                              setState(() {
                                                hourIndex = value + 1;
                                              });
                                            });
                                          },
                                          children: List.generate(
                                            12,
                                            (index) => Container(
                                              width: 100,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${index + 1}',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        //분
                                        child: ListWheelScrollView.useDelegate(
                                          controller: _controller,
                                          physics: FixedExtentScrollPhysics(),
                                          itemExtent: 50.0,
                                          diameterRatio: 1.5,
                                          perspective: 0.005,
                                          onSelectedItemChanged: (value) {
                                            bottomState(() {
                                              setState(() {
                                                minuteIndex = int.parse(value
                                                    .toString()
                                                    .padLeft(2, '0'));
                                              });
                                            });
                                          },
                                          childDelegate:
                                              ListWheelChildLoopingListDelegate(
                                                  children: List.generate(
                                            60,
                                            (index) => Container(
                                              width: 100,
                                              alignment: Alignment.center,
                                              child: Text(
                                                index
                                                    .toString()
                                                    .padLeft(2, '0'),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                color: Colors.blue,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('취소'),
                                    Text(
                                      '${timeone[selectedIndexs]} ${hourIndex.toString().padLeft(2, '0')} ${minuteIndex.toString().padLeft(2, '0')}',
                                    ),
                                    Text('등록'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                    });
              },
              child: Text('3dlist')),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DatePickTest()));
            },
            child: Text('달력테스트'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const GraphTest()));
            },
            child: Text('그래프 테스트'),
          ),
        ],
      ),
    );
  }
}
