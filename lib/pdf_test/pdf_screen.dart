// import 'package:flutter/material.dart';
// import 'package:pdfx/pdfx.dart';
// import 'package:pinch_zoom/pinch_zoom.dart';
// import 'package:zoom_widget/zoom_widget.dart';

// class PdfScreen extends StatefulWidget {
//   const PdfScreen({super.key});

//   @override
//   State<PdfScreen> createState() => _PdfScreenState();
// }

// class _PdfScreenState extends State<PdfScreen> {
//   static const int _initialPage = 1;
//   late PdfController _pdfController;

//   int pageTotal = 0;
//   int currentPage = 1;
//   bool showNum = false;
//   bool loadComplete = false;
//   bool previousButtonVisible = false;
//   bool nextButtonVisible = false;

//   @override
//   void initState() {
//     _pdfController = PdfController(
//       document: PdfDocument.openAsset('assets/SQISOFT_Catalog_kor.pdf'),
//       initialPage: _initialPage,
//     );
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _pdfController.dispose();
//     super.dispose();
//   }

//   void onDocumentLoaded(PdfDocument document) {
//     if (mounted) {
//       setState(() {
//         pageTotal = document.pagesCount;
//         //if (widget.showBottomPage) {
//         showNum = true;
//         //}

//         loadComplete = true;
//         print('load complete');
//         checkButtonVisible(1, pageTotal);
//       });
//     }
//   }

//   void onPageChanged(int page) {
//     print('onPageChange:$page');
//     setState(() {
//       currentPage = page;
//       checkButtonVisible(page, pageTotal);
//     });
//   }

//   void checkButtonVisible(int index, int total) {
//     print('checkButtonVisible index:$index, total:$total');
//     if (total == 1) {
//       previousButtonVisible = false;
//       nextButtonVisible = false;
//       return;
//     }
//     //처음
//     if (index == 0) {
//       previousButtonVisible = false;
//       nextButtonVisible = true;
//     }
//     if (index == 1) {
//       previousButtonVisible = false;
//       nextButtonVisible = true;
//     } else if (index == total) {
//       previousButtonVisible = true;
//       nextButtonVisible = false;
//     } else {
//       previousButtonVisible = true;
//       nextButtonVisible = true;
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       color: Colors.blue,
//       child: Stack(
//         children: [
//           Zoom(
//             // resetDuration: const Duration(milliseconds: 100),
//             // maxScale: 2.5,
//             // onZoomStart: () {
//             //   print('Start zooming');
//             // },
//             // onZoomEnd: () {
//             //   print('Stop zooming');
//             // },
//             maxZoomWidth: 500,
//             maxZoomHeight: 500,
//             // initTotalZoomOut: true,
//             child: PdfView(
//               //pdfview는 안에 감쌀게 아니라 약간 ... 개인이 있어야하는 느낌..
//               controller: _pdfController,
//               builders: PdfViewBuilders<DefaultBuilderOptions>(
//                 options: DefaultBuilderOptions(),
//                 pageBuilder: (context, pageImage, index, document) {
//                   return PhotoViewGalleryPageOptions(
//                     imageProvider: PdfPageImageProvider(
//                       pageImage,
//                       index,
//                       document.id,
//                     ),
//                     minScale: PhotoViewComputedScale.contained * 1,
//                     maxScale: PhotoViewComputedScale.contained * 3.0,
//                     filterQuality: FilterQuality.high,
//                     heroAttributes:
//                         PhotoViewHeroAttributes(tag: '${document.id}-$index'),
//                   );
//                 },
//                 documentLoaderBuilder: (_) => Container(
//                   color: Colors.white,
//                   child: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 ),
//                 pageLoaderBuilder: (_) => Container(
//                   color: Colors.white,
//                   child: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 ),
//               ),
//               onPageChanged: onPageChanged,
//               onDocumentLoaded: onDocumentLoaded,
//             ),
//           ),
//           IntrinsicHeight(
//             // Row 내에서 가장 높은 높이를 가진 크기만큼 모두 갖게 됨
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.navigate_before),
//                   onPressed: () {
//                     _pdfController.previousPage(
//                       curve: Curves.ease,
//                       duration: const Duration(milliseconds: 100),
//                     );
//                   },
//                 ),
//                 Center(
//                   child: PdfPageNumber(
//                     controller: _pdfController,
//                     builder: (_, loadingState, page, pagesCount) => Container(
//                       child: Text(
//                         '$page/${pagesCount ?? 0}',
//                         style:
//                             const TextStyle(fontSize: 22, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.navigate_next),
//                   onPressed: () {
//                     _pdfController.nextPage(
//                       curve: Curves.ease,
//                       duration: const Duration(milliseconds: 100),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
