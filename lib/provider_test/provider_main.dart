import 'package:flutter/material.dart';

class ProviderMain extends StatefulWidget {
  static String get routeName => 'ProviderMain';
  const ProviderMain({super.key});

  @override
  State<ProviderMain> createState() => _ProviderMainState();
}

class _ProviderMainState extends State<ProviderMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.amber,
      child: Column(
        children: [ElevatedButton(onPressed: () {}, child: Text('provider'))],
      ),
    );
  }
}
