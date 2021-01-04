// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update_apk_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUpdateApkBean _$AppUpdateApkBeanFromJson(Map<String, dynamic> json) {
  return AppUpdateApkBean(
    json['Id'] as String,
    json['Name'] as String,
    json['Suffix'] as String,
    json['Size'] as int,
    json['Versions'] as String,
    json['UpdateRemark'] as String,
    json['FileAddress'] as String,
    json['IsForceUpdateValue'] as String,
  );
}

Map<String, dynamic> _$AppUpdateApkBeanToJson(AppUpdateApkBean instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Suffix': instance.suffix,
      'Size': instance.size,
      'Versions': instance.version,
      'UpdateRemark': instance.remark,
      'FileAddress': instance.fileAddress,
      'IsForceUpdateValue': instance.isForceUpdateValue,
    };
