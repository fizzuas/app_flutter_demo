import 'package:flutter/material.dart';
import 'package:flutter_app/db/data_access.dart';

import 'dataaccess_database.dart';

class DBContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          FlatButton(
            onPressed: () {
              _insert();
            },
            child: Text("insert"),
          ),
          FlatButton(
            onPressed: () {
              _delete();
            },
            child: Text("delete"),
          ),
          FlatButton(
            onPressed: () {
              _query();
            },
            child: Text("query"),
          ),
          FlatButton(
            onPressed: () {
              _upgrade();
            },
            child: Text("upgrade"),
          ),
        ],
      ),
    );
  }

  void _insert() async {
    int result = await DataAccessDatabase.instance
        .insertValidMachine(DataAccess(sn: "ssss", dataAccessCode: "bbbbb"));
    print("_insert resulte=" + result.toString());
  }

  void _delete() async {
    int result = await DataAccessDatabase.instance.deleteMachine(
      "ssss",
    );
    print("_delete resulte=" + result.toString());
  }

  void _query() async {
    List<DataAccess> list =
        await DataAccessDatabase.instance.queryValidMachine("ssss");
    list.forEach((element) {
      print(element.toString());
    });
  }

  void _upgrade() {}
}
