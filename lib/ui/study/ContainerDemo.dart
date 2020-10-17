
import 'package:flutter/material.dart';

class ContainerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(primaryColor: Colors.red, accentColor: Colors.redAccent),
      title: "ss",
      home: new Scaffold(
        appBar: AppBar(
          title: Text("ss"),
        ),
        body: new Container(
          alignment: Alignment.bottomRight,
          color: Colors.blue,
          width: 600,
          height: 600,
          margin: EdgeInsets.all(1),
          padding: EdgeInsets.all(25),
          child: new Container(
            alignment: Alignment.bottomRight,
            color: Colors.red,
            width: 300,
            height: 300,
            padding: EdgeInsets.all(10),
            child: new Image.asset(
              "images/lake.jpg",
              width: 50,
            ),
//            constraints: new BoxConstraints.expand(width: 300,height: 300),
          ),
//          constraints: new BoxConstraints.expand(width: 600,height: 600),
        ),
      ),
    );
  }
}