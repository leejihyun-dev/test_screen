import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_screen_change/router_test/frame_view.dart';

enum MenuType {
  //메뉴별 색상 다르게 표시 kesco: 검정, ceo: 파랑 media: 제외
  kesco,
  ceo,
  media,
}

class ImageView extends StatefulWidget {
  final MenuType? menuType;
  final LayoutTypes? type;
  final String? mainText;
  final String? subText;
  final String fileUrl;
  const ImageView(
      {super.key,
      this.menuType,
      this.type,
      this.mainText,
      this.subText,
      required this.fileUrl});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1920,
      height: 1080,
      child: LayoutTypes.typea == widget.type
          ? Container(
              width: 1920,
              height: 1080,
              // margin: EdgeInsets.only(
              //   //제목, 내용이 없는 경우
              //   top: widget.mainText!.isEmpty && widget.subText!.isEmpty
              //       ? 280
              //       : 200,
              //   left: widget.mainText!.isEmpty && widget.subText!.isEmpty
              //       ? 500
              //       : 200,
              // ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.asset(
                  'assets/view_image_sample.png',
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Positioned.fill(
              child: Image.asset(
                'assets/view_image_sample.png',
                fit: BoxFit.cover,
              ),
            ),

      // children: [
      // if (LayoutTypes.typea == widget.type) Image.asset('assets/home_bg.png'),
      // if (LayoutTypes.typea == widget.type)
      //   Container(
      //     width: 1920,
      //     height: 1080,
      //     margin: EdgeInsets.only(
      //       //제목, 내용이 없는 경우
      //       top: widget.mainText!.isEmpty && widget.subText!.isEmpty
      //           ? 280
      //           : 200,
      //       left: widget.mainText!.isEmpty && widget.subText!.isEmpty
      //           ? 500
      //           : 200,
      //     ),
      //     child: ClipRRect(
      //       borderRadius: BorderRadius.circular(200),
      //       child: Image.asset(
      //         'assets/view_image_sample.png',
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //   ),
      // if (LayoutTypes.typeb == widget.type)
      //   Positioned.fill(
      //     child: Image.asset(
      //       'assets/view_image_sample.png',
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      // Align(
      //   alignment: Alignment.bottomRight,
      //   child: Visibility(
      //     visible: widget.subText!.isNotEmpty || widget.mainText!.isEmpty
      //         ? true //내용이 있거나 제목이 없는 경우
      //         : false,
      //     child: Container(
      //       color: (MenuType.kesco == widget.menuType)
      //           ? Colors.black.withOpacity(0.5)
      //           : const Color(0XFF00609C).withOpacity(0.8),
      //       width: 600,
      //       height: 300,
      //       child: Padding(
      //         padding: const EdgeInsets.all(110),
      //         child: (widget.mainText!.isEmpty) //제목이 없는 경우
      //             ? Center(
      //                 child: Text(
      //                   // '한국전기안전공사 KESCO(사장 이지현)는 10일, 정읍 첨단과학산업단지 내 대한민국 전기안전 인재육성의 메카인 전기안전인재개발원 개원식을 개최하였다.',
      //                   '${widget.subText}',
      //                   style: const TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 30,
      //                     fontWeight: FontWeight.w500,
      //                     height: 1.6,
      //                   ),
      //                 ),
      //               )
      //             : Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   SizedBox(
      //                       width: 500,
      //                       child: Text(
      //                         // '한국전기안전공사, 전기안전인재개발원 개원 콘텐츠',
      //                         // '전기 안전인재개발원', //한줄짜리
      //                         '${widget.mainText}',
      //                         style: const TextStyle(
      //                             color: Colors.white,
      //                             fontSize: 20,
      //                             fontWeight: FontWeight.w700,
      //                             overflow: TextOverflow.ellipsis,
      //                             height: 1.3),
      //                         maxLines: 2,
      //                       )),
      //                   Container(
      //                     width: 100,
      //                     height: 6,
      //                     color: Colors.white.withOpacity(0.5),
      //                   ),
      //                   SizedBox(
      //                     width: 500,
      //                     child: Text(
      //                       // '한국전기안전공사 KESCO(사장 이지현)는 10일, 정읍 첨단과학산업단지 내 대한민국 전기안전 인재육성의 메카인 전기안전인재개발원 개원식을 개최하였다.',
      //                       '${widget.subText}',
      //                       // '메카인 전기안전인재개발원 개원식을 개최하였다', //한줄짜리
      //                       style: const TextStyle(
      //                         color: Colors.white,
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.w500,
      //                         overflow: TextOverflow.ellipsis,
      //                         height: 1.6,
      //                       ),
      //                       maxLines: 3,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //       ),
      //     ),
      //   ),
      // ),
      // ],
    );
  }
}
