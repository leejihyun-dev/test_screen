import 'package:flutter/material.dart';
// import 'package:pdfx/pdfx.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreenTwo extends StatefulWidget {
  const PdfScreenTwo({super.key});

  @override
  State<PdfScreenTwo> createState() => _PdfScreenTwoState();
}

class _PdfScreenTwoState extends State<PdfScreenTwo> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController _pdfViewerController = PdfViewerController();

  static const int _initialPage = 1;

  int pageTotal = 0;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
  }

  void onPageChanged(int page) {
    print('onPageChange:$page');
    setState(() {
      currentPage = page;
    });
  }

  void onDocumentLoaded(PdfDocumentLoadedDetails document) {
    print('document ${document.document.pages}');

    if (mounted) {
      setState(() {
        //pageTotal = document.pagesCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: SfPdfViewer.asset(
              'assets/SQISOFT_Catalog_kor.pdf',
              key: _pdfViewerKey,
              pageLayoutMode: PdfPageLayoutMode.single,
              controller: _pdfViewerController,
              onDocumentLoaded: onDocumentLoaded,
            ),
          ),
          Visibility(
            visible: pageTotal > 1 ? true : true,
            child: IntrinsicHeight(
              // Row 내에서 가장 높은 높이를 가진 크기만큼 모두 갖게 됨
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.navigate_before,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      _pdfViewerController.previousPage();
                    },
                  ),
                  // Center(
                  //   child: PdfPageNumber(
                  //     controller: _pdfViewerController,
                  //     builder: (_, loadingState, page, pagesCount) => Container(
                  //       child: Text(
                  //         '$page/${pagesCount ?? 0}',
                  //         style: const TextStyle(fontSize: 22),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  IconButton(
                    icon: const Icon(
                      Icons.navigate_next,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      _pdfViewerController.nextPage();
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.zoom_in,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _pdfViewerController.zoomLevel = 2;
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.zoom_out,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _pdfViewerController.zoomLevel = 1;
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
