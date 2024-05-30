// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frame_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FrameModelImpl _$$FrameModelImplFromJson(Map<String, dynamic> json) =>
    _$FrameModelImpl(
      id: json['id'] as String?,
      layoutType: json['layoutType'] == null
          ? null
          : LayoutType.fromJson(json['layoutType'] as Map<String, dynamic>),
      mainText: json['mainText'] as String?,
      subText: json['subText'] as String?,
      useYn: json['useYn'] as String?,
      screenEffect: json['screenEffect'] as String?,
      transformTime: json['transformTime'] as String?,
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => ContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FrameModelImplToJson(_$FrameModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'layoutType': instance.layoutType,
      'mainText': instance.mainText,
      'subText': instance.subText,
      'useYn': instance.useYn,
      'screenEffect': instance.screenEffect,
      'transformTime': instance.transformTime,
      'content': instance.content,
    };
