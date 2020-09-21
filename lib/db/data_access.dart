class DataAccess {
  int id;
  String sn;
  String dataAccessCode;

  DataAccess({this.id,this.sn, this.dataAccessCode});

  Map<String, dynamic> toJson() => {
        'id': id,
        'sn': sn,
        'dataAccessCode': dataAccessCode,
      };

  DataAccess.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sn = json['sn'];
    dataAccessCode = json['dataAccessCode'];
  }
  @override
  String toString() {

    return toJson().toString();
  }
}
