class TestImgModel {
  String? imgUrl;
  bool? selectImg;
  String? imagType;

  TestImgModel({
    required this.imgUrl,
    required this.selectImg,
    required this.imagType,
  });

  Map<String, dynamic> toMap() {
    return {
      'imgUrl': imgUrl,
      'selectImg': selectImg,
      'imagType': imagType,
    };
  }

  TestImgModel.fromMap(Map<dynamic, dynamic>? map) {
    imgUrl = map?['imgUrl'];
    selectImg = map?['selectImg'];
    imagType = map?['imagType'];
  }
}
