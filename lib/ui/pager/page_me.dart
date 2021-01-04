import 'package:flutter/material.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("me build");
    return Center(child:Text("MePage"));
  }
  @override
  bool get wantKeepAlive => false;
}
