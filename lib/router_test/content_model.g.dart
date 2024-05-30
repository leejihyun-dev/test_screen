// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentModelImpl _$$ContentModelImplFromJson(Map<String, dynamic> json) =>
    _$ContentModelImpl(
      id: json['id'] as String?,
      transformTime: json['transformTime'] as String?,
      content: json['content'] == null
          ? null
          : ContentData.fromJson(json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ContentModelImplToJson(_$ContentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transformTime': instance.transformTime,
      'content': instance.content,
    };
