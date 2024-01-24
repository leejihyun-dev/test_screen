import 'package:flutter/material.dart';

class RecodeScreen extends StatefulWidget {
  const RecodeScreen({super.key});

  @override
  State<RecodeScreen> createState() => _RecodeScreenState();
}

class _RecodeScreenState extends State<RecodeScreen> {
  DateTime test = DateTime(
    DateTime.now().subtract(Duration(days: 30)).month,
    DateTime.now().subtract(Duration(days: 30)).day,
  );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
