import 'package:flutter/material.dart';

class ColumnSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "",
      home: Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: getBody(),
      ),
    );
  }

  getBody() {
    return Column(
      children: <Widget>[
        getItem("消息记录", Icons.chat),
        getItem("我的收藏", Icons.stars),
      ],
    );
  }

  getItem(String s, IconData iconData) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: new Border(bottom: new BorderSide(color: Colors.grey))),
      child: Row(
        children: <Widget>[
          Icon(iconData),
          Expanded(
            child: Text(
              s,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
