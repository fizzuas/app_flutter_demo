
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageInput extends StatefulWidget {
  @override
  _PageInputState createState() => _PageInputState();
}

class _PageInputState extends State<PageInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        child: Center(
          child:ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 100,maxWidth: 80) ,
            child: Stack(
              alignment:Alignment.center,
              children: [
                TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(3)],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24.0,
                ),
                /// 设置输入框样式
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  // 填充颜色属性，填充装饰容器的颜色。
                  fillColor:  Colors.blue,
                  // 填充属性，如果为`true`，则装饰的容器将填充fillColor颜色。
                  filled: true,
                  ///设置内容内边距
                  contentPadding: EdgeInsets.only(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    left: 0
                  ),

                ),
              ),
                Positioned(child: Text("%"),
                bottom: 5,
                right: 5,)
            ]
                
            ),
          ),
        ),
      ),
    );
  }
}
