
import 'package:json_annotation/json_annotation.dart';

part 'app_update_apk_bean.g.dart';

@JsonSerializable()
class AppUpdateApkBean{
  @JsonKey(name: "Id")
  String id;
  @JsonKey(name: "Name")
  String name;
  @JsonKey(name: "Suffix")
  String suffix;
  @JsonKey(name: "Size")
  int size;
  @JsonKey(name: "Versions")
  String version;
  @JsonKey(name: "UpdateRemark")
  String remark;
  @JsonKey(name: "FileAddress")
  String fileAddress;
  @JsonKey(name: "IsForceUpdateValue")
  String isForceUpdateValue;

  AppUpdateApkBean(this.id, this.name, this.suffix,
      this.size, this.version, this.remark,this.fileAddress,this.isForceUpdateValue);
  @override
  String toString() {
    return 'AppUpdateApkBean{ id: $id, name: $name, suffix: $suffix, size: $size, version: $version, remark: $remark, fileAddress: $fileAddress,isForceUpdateValue: $isForceUpdateValue}';
  }

  factory AppUpdateApkBean.fromJson(Map<String, dynamic> json) => _$AppUpdateApkBeanFromJson(json);


  Map<String, dynamic> toJson() => _$AppUpdateApkBeanToJson(this);

}