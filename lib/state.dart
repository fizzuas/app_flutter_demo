import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyApp",
      home: new Scaffold(
          appBar: AppBar(
            title: Text("title"),
          ),
          body: Center(
            child: Home(),
          )),
    );
  }
}

class Home extends StatefulWidget {
  int curNum = 0;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int curNum = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Text(
            "$curNum",
            style: TextStyle(fontSize: 42),
          ),
        ),
        Container(
          child: FlatButton(
            child: Text(
              "+",
              style: TextStyle(fontSize: 42),
            ),
            onPressed: () {
              add();
            },
          ),
        ),
        Container(
          child: FlatButton(
            child: Text(
              "-",
              style: TextStyle(fontSize: 42),
            ),
            onPressed: () {
              minus();
            },
          ),
        )
      ],
    );
  }

  add() {
    setState(() {
      curNum += 1;
      print("add $curNum");
    });
  }

  minus() {
    setState(() {
      curNum -= 1;
      print("add $curNum");
    });
  }
}
