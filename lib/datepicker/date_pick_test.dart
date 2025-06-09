import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DatePickTest extends StatefulWidget {
  const DatePickTest({super.key});

  @override
  State<DatePickTest> createState() => _DatePickTestState();
}

class _DatePickTestState extends State<DatePickTest> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                Text('주기 선택'),
                TableCalendar(
                  focusedDay: DateTime.now(),
                  firstDay:
                      DateTime.now().subtract(const Duration(days: 365 * 10)),
                  lastDay: DateTime.now().add(const Duration(days: 365 * 10)),
                  locale: 'ko-KR',
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: _rangeSelectionMode,
                  daysOfWeekHeight: 30,
                  calendarStyle: CalendarStyle(
                    defaultDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey[200],
                      // borderRadius: BorderRadius.zero,
                    ),
                    selectedDecoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        // borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        )),
                    outsideDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    rangeStartDecoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.rectangle,
                    ),
                    rangeEndDecoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        _rangeStart = null; // Important to clean those
                        _rangeEnd = null;
                        _rangeSelectionMode = RangeSelectionMode.toggledOff;
                      });
                    }
                  },
                  onRangeSelected: (start, end, focusedDay) {
                    if (start != null) {
                      final calculatedEnd = start.add(Duration(days: 6));

                      setState(() {
                        _selectedDay = null;
                        _focusedDay = focusedDay;
                        _rangeStart = start;
                        _rangeEnd = calculatedEnd;
                        _rangeSelectionMode = RangeSelectionMode.toggledOn;
                      });
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('뒤로가기'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
