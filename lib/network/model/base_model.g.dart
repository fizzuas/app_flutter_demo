// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModel _$BaseModelFromJson(Map<String, dynamic> json) {
  return BaseModel(
    json['Code'] as int,
    json['Detail'] as String,
    json['Message'] as String,
    json['Value'],
  );
}

Map<String, dynamic> _$BaseModelToJson(BaseModel instance) => <String, dynamic>{
      'Code': instance.code,
      'Detail': instance.detail,
      'Message': instance.message,
      'Value': instance.value,
    };
