// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppPosition _$AppPositionFromJson(Map<String, dynamic> json) {
  return AppPosition(
    longitude: json['Longitude'] as String,
    latitude: json['Latitude'] as String,
    addressDetail: json['AddressDetail'] as String,
    country: json['Country'] as String,
    province: json['Province'] as String,
    city: json['City'] as String,
    district: json['District'] as String,
    street: json['Street'] as String,
    addressCode: json['AddressCode'] as String,
    town: json['Town'] as String,
    poi: json['Poi'] as String,
    addressDesc: json['AddressDesc'] as String,
    gpsSpeed: json['GpsSpeed'] as int,
    direction: json['Direction'] as int,
    height: (json['Height'] as num)?.toDouble(),
    radius: (json['Radius'] as num)?.toDouble(),
    phoneCode: json['PhoneCode'] as String,
    createTime: json['CreateTime'] as String,
  );
}

Map<String, dynamic> _$AppPositionToJson(AppPosition instance) =>
    <String, dynamic>{
      'Longitude': instance.longitude,
      'Latitude': instance.latitude,
      'AddressDetail': instance.addressDetail,
      'Country': instance.country,
      'Province': instance.province,
      'City': instance.city,
      'District': instance.district,
      'Street': instance.street,
      'AddressCode': instance.addressCode,
      'Town': instance.town,
      'Poi': instance.poi,
      'AddressDesc': instance.addressDesc,
      'GpsSpeed': instance.gpsSpeed,
      'Direction': instance.direction,
      'Height': instance.height,
      'Radius': instance.radius,
      'PhoneCode': instance.phoneCode,
      'CreateTime': instance.createTime,
    };
