import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with TickerProviderStateMixin {
  TabController _controller;
  TextStyle style = TextStyle(fontSize: 40);
  List<String> list = ["页面1", "页面2", "页面3"];

  TextStyle bigStyle = TextStyle(fontSize: 20);
  TextStyle smlStyle = TextStyle(fontSize: 14);

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new MaterialApp(
          title: 'Welcome to Flutter',
          home: new Scaffold(
            appBar: new AppBar(
              centerTitle: true,
              title: Container(
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(60),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey[500],
                    ),
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              bottom: TabBar(
                labelPadding: EdgeInsets.symmetric(horizontal: 5),
                controller: _controller,
                tabs: list.map((e) => Text(e)).toList(),
                isScrollable: false,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 80),
                labelColor: Colors.white,
                indicatorWeight: 2,
                unselectedLabelStyle: smlStyle,
                labelStyle: bigStyle,
              ),
//          leading: Icon(Icons.arrow_back),
            ),
            body: TabBarView(
              controller: _controller,
              children: list
                  .map((e) => Center(
                child: Text(
                  e,
                  style: style,
                ),
              ))
                  .toList(),
            ),
          ),
        ));
  }
}
