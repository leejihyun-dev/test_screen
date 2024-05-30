import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_screen_change/router_test/content_model.dart';
import 'package:test_screen_change/router_test/layout_type.dart';

part 'frame_model.g.dart';
part 'frame_model.freezed.dart';

@freezed
class FrameModel with _$FrameModel {
  factory FrameModel({
    String? id,
    LayoutType? layoutType,
    String? mainText,
    String? subText,
    String? useYn,
    String? screenEffect,
    String? transformTime,
    List<ContentModel>? content,
  }) = _FrameModel;

  factory FrameModel.fromJson(Map<String, dynamic> json) =>
      _$FrameModelFromJson(json);
}
