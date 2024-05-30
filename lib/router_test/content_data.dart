import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_data.g.dart';
part 'content_data.freezed.dart';

@freezed
class ContentData with _$ContentData {
  factory ContentData({
    String? id,
    String? filePath,
    String? fileNm,
    String? thumbFileNm,
    String? fileOrgNm,
    String? mimeTp,
    int? fileSize,
    int? thumbFileSize,
    int? oder,
    String? createDt,
  }) = _ContentData;

  factory ContentData.fromJson(Map<String, dynamic> json) =>
      _$ContentDataFromJson(json);
}
