
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_app/util/view_size_utils.dart';

class PageInput extends StatefulWidget {
  @override
  _PageInputState createState() => _PageInputState();
}

class _PageInputState extends State<PageInput> {
  TextEditingController _controller=TextEditingController();

 void init(VoidCallback s){

 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        child: Center(
         child: _getInputText(_controller),
        ),
      ),
    );
  }

  _getInputText(TextEditingController controller) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: ViewSizeUtils.getSize(59),
          maxWidth: ViewSizeUtils.getSize(104)),
      child: Stack(alignment: Alignment.center, children: [
        TextField(
          controller: controller,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
            FilteringTextInputFormatter.allow(RegExp(r'-?[0-9]{0,10}')),
            LengthLimitingTextInputFormatter(4)
          ],


          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xff616161),
            fontSize: ViewSizeUtils.setSp(32),
          ),

          /// 设置输入框样式
          decoration: InputDecoration(
              border: OutlineInputBorder(
                ///设置边框四个角的弧度
                borderRadius: BorderRadius.all(Radius.circular(10)),
                ///用来配置边框的样式
                borderSide: BorderSide(
                  ///设置边框的颜色
                  color: Colors.red,
                  ///设置边框的粗细
                  width: 2.0,
                ),
              ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
              color: Colors.red,  // 边框颜色
              ),
            ),

            // fillColor: Color(0xfff5f5f5),
            // // 填充属性，如果为`true`，则装饰的容器将填充fillColor颜色。
            // filled: true,

            ///设置内容内边距 ,输入文字居中
            contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 0),
          ),
        ),
        Positioned(
          child: Text(
            "%",
            style: TextStyle(color: Color(0xff616161)),
          ),
          bottom: 5,
          right: 5,
        )
      ]),
    );
  }
}
