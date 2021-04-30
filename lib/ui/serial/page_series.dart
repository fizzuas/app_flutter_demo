import 'package:flutter/material.dart';
import 'package:flutter_app/base/_base_widget.dart';
import 'package:flutter_app/ui/serial/app_position.dart';
import 'package:flutter_app/ui/title/common_titleview.dart';

class PageSeries extends StatefulWidget {
  @override
  _PageSeriesState createState() => _PageSeriesState();
}

class _PageSeriesState extends BaseWidgetState<PageSeries> {
  String _value="";

  @override
  void initData() {}

  @override
  Widget initTitleView() {
    return CommonTitleView(
      titleName: "序列化",
    );
  }

  @override
  Widget setPageLayout(BuildContext context) {
    return Column(
      children: [
        FlatButton(onPressed: () {
          // 测试序列化
          AppPosition position = AppPosition(longitude: "11", latitude: "22");

          setState(() {
            _value=position.toJson().toString();
          });
        },child: Text("序列化"),),
        Text(_value,style: TextStyle(color: Colors.red),)
      ],
    );
  }
}
