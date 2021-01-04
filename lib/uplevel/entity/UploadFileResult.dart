

class UploadFileResult {
  double Version;

  UploadFileResult(this.Version);

  Map<String, dynamic> toJson(UploadFileResult instance) => <String, dynamic>{
    "Version": instance.Version,
  };
}