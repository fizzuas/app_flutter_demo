// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bean_upload_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadFileResultNetWork _$UploadFileResultNetWorkFromJson(
    Map<String, dynamic> json) {
  return UploadFileResultNetWork(
    json['OriginalName'] as String,
    json['Suffix'] as String,
    (json['Size'] as num)?.toDouble(),
    json['FileAddress'] as String,
    (json['Version'] as num)?.toDouble(),
    json['Remark'] as String,
  );
}

Map<String, dynamic> _$UploadFileResultNetWorkToJson(
        UploadFileResultNetWork instance) =>
    <String, dynamic>{
      'OriginalName': instance.originalName,
      'Suffix': instance.suffix,
      'Size': instance.size,
      'FileAddress': instance.fileAddress,
      'Version': instance.version,
      'Remark': instance.remark,
    };
