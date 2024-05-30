// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentDataImpl _$$ContentDataImplFromJson(Map<String, dynamic> json) =>
    _$ContentDataImpl(
      id: json['id'] as String?,
      filePath: json['filePath'] as String?,
      fileNm: json['fileNm'] as String?,
      thumbFileNm: json['thumbFileNm'] as String?,
      fileOrgNm: json['fileOrgNm'] as String?,
      mimeTp: json['mimeTp'] as String?,
      fileSize: json['fileSize'] as int?,
      thumbFileSize: json['thumbFileSize'] as int?,
      oder: json['oder'] as int?,
      createDt: json['createDt'] as String?,
    );

Map<String, dynamic> _$$ContentDataImplToJson(_$ContentDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filePath': instance.filePath,
      'fileNm': instance.fileNm,
      'thumbFileNm': instance.thumbFileNm,
      'fileOrgNm': instance.fileOrgNm,
      'mimeTp': instance.mimeTp,
      'fileSize': instance.fileSize,
      'thumbFileSize': instance.thumbFileSize,
      'oder': instance.oder,
      'createDt': instance.createDt,
    };
