// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestModelImpl _$$TestModelImplFromJson(Map<String, dynamic> json) =>
    _$TestModelImpl(
      type: json['type'] as String?,
      roomId: json['roomId'] as String?,
      sender: json['sender'] as String?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$$TestModelImplToJson(_$TestModelImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'roomId': instance.roomId,
      'sender': instance.sender,
      'msg': instance.msg,
    };
