import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_model.g.dart';
part 'test_model.freezed.dart';

@freezed
class TestModel with _$TestModel {
  factory TestModel({
    String? type,
    String? roomId,
    String? sender,
    String? msg,
  }) = _TestModel;

  factory TestModel.fromJson(Map<String, dynamic> json) =>
      _$TestModelFromJson(json);
}
