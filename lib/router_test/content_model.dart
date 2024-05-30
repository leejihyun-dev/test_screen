import 'package:freezed_annotation/freezed_annotation.dart';

import 'content_data.dart';

part 'content_model.g.dart';
part 'content_model.freezed.dart';

@freezed
class ContentModel with _$ContentModel {
  factory ContentModel({
    String? id,
    String? transformTime,
    ContentData? content,
  }) = _ContentModel;

  factory ContentModel.fromJson(Map<String, dynamic> json) =>
      _$ContentModelFromJson(json);
}
