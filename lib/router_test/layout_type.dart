import 'package:freezed_annotation/freezed_annotation.dart';
part 'layout_type.g.dart';
part 'layout_type.freezed.dart';

@freezed
class LayoutType with _$LayoutType {
  factory LayoutType({
    String? code,
    String? desc,
  }) = _LayoutType;

  factory LayoutType.fromJson(Map<String, dynamic> json) =>
      _$LayoutTypeFromJson(json);
}
