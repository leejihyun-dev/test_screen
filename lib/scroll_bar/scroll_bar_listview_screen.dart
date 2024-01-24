import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_screen_change/scroll_bar/scroll_provider.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HorizontalIndicatorProvider>(
      create: (_) => HorizontalIndicatorProvider(),
      child: Consumer<HorizontalIndicatorProvider>(
          builder: (context, value, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NotificationListener<ScrollUpdateNotification>(
              onNotification: ((notification) {
                value.scrollListener(
                    notification: notification,
                    widthSize: (MediaQuery.of(context).size.width / 3) -
                        (MediaQuery.of(context).size.width / 5) / 2);
                return false;
              }),
              child: Container(
                width: 1000,
                height: 500,
                color: Colors.amber,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 500,
                      height: 100,
                      color: Colors.accents[index],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromRGBO(91, 91, 91, 1),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        left: value.scrollPosition,
                        child: Container(
                          height: 5,
                          width: (MediaQuery.of(context).size.width / 5) / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.blue),
                        )),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
