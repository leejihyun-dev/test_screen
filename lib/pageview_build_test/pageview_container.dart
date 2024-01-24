import 'package:flutter/material.dart';

class PageViewContainer extends StatefulWidget {
  const PageViewContainer({super.key});

  @override
  State<PageViewContainer> createState() => _PageViewContainerState();
}

class _PageViewContainerState extends State<PageViewContainer> {
  final List<int> pages = List.generate(4, (index) => index);
  List<String> pageName = ["First Page", "Second Page", "Third Page"];
  int currentPage = 0;
  final PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: (value) {
        setState(() {
          currentPage = value;
        });
      },
      itemCount: pageName.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.blue.withOpacity(index * 0.1),
          child: Center(
            child: Text(
              pageName[index],
              style: TextStyle(fontSize: 50),
            ),
          ),
        );
      },
    );
    // return Scaffold(
    //   body: Container(
    //     width: double.infinity,
    //     height: double.infinity,
    //     decoration: BoxDecoration(
    //       color: Colors.amber,
    //       borderRadius: BorderRadius.circular(50),
    //     ),
    //     child: PageView.builder(
    //       controller: controller,
    //       itemCount: pages.length,
    //       onPageChanged: (page) {
    //         setState(() {
    //           currentPage = page;
    //         });
    //       },
    //       itemBuilder: (context, index) {
    //         return Container(
    //           padding: EdgeInsets.all(10),
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(20),
    //             color: Colors.white,
    //           ),
    //           child: Text('$index'),
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}
