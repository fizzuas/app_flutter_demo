import 'package:json_annotation/json_annotation.dart';

part 'app_position.g.dart';

@JsonSerializable()
class AppPosition extends Object {
  @JsonKey(name: 'Longitude')
  String longitude;

  @JsonKey(name: 'Latitude')
  String latitude;

  @JsonKey(name: 'AddressDetail')
  String addressDetail;

  @JsonKey(name: 'Country')
  String country;

  @JsonKey(name: 'Province')
  String province;

  @JsonKey(name: 'City')
  String city;

  @JsonKey(name: 'District')
  String district;

  @JsonKey(name: 'Street')
  String street;

  @JsonKey(name: 'AddressCode')
  String addressCode;

  @JsonKey(name: 'Town')
  String town;

  @JsonKey(name: 'Poi')
  String poi;

  @JsonKey(name: 'AddressDesc')
  String addressDesc;

  @JsonKey(name: 'GpsSpeed')
  int gpsSpeed;

  @JsonKey(name: 'Direction')
  int direction;

  @JsonKey(name: 'Height')
  double height;

  @JsonKey(name: 'Radius')
  double radius;

  @JsonKey(name: 'PhoneCode')
  String phoneCode;

  @JsonKey(name: 'CreateTime')
  String createTime;

  AppPosition({
    this.longitude,
    this.latitude,
    this.addressDetail,
    this.country,
    this.province,
    this.city,
    this.district,
    this.street,
    this.addressCode,
    this.town,
    this.poi,
    this.addressDesc,
    this.gpsSpeed,
    this.direction,
    this.height,
    this.radius,
    this.phoneCode,
    this.createTime,
  });

  factory AppPosition.fromJson(Map<String, dynamic> srcJson) =>
      _$AppPositionFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AppPositionToJson(this);
}
