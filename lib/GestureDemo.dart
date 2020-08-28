import 'package:flutter/material.dart';

class GestureDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: GestureDetector(
              child: new Icon(
                Icons.android,
                size: 200,
              ),
              onTap: (){
                print("onTab");
              },
              onDoubleTap: (){
                print("onDouble Tab");
              },
              onLongPress: (){
                print("onLongPress");
              },
              onVerticalDragStart: (details){
                print("在垂直方向开始位置:"+details.globalPosition.toString());
              },
              onVerticalDragEnd: (details){
              print("在垂直方向结束位置:"+details.primaryVelocity.toString());
            },
            )
          ),
        ),
      ),
    );
  }
}
