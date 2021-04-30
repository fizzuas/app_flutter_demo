import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_app/base/_base_widget.dart';
import 'package:flutter_app/ui/title/common_titleview.dart';
import 'package:flutter_app/util/view_size_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';


class PageSignalAdjust extends StatefulWidget {
  @override
  _PageSignalAdjustState createState() => _PageSignalAdjustState();
}

class _PageSignalAdjustState extends BaseWidgetState<PageSignalAdjust> {
  var shouldContinueInterruptedAction = false; // 是否继续未完成操作 用来恢复被被连接蓝牙打断的动作
  TextEditingController _controller = TextEditingController()..text="0";

  @override
  void initData() {
  }

  @override
  Widget initTitleView() {
    return CommonTitleView(titleName: "");
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget setPageLayout(BuildContext context) {
    return Builder(builder: (context) {
      return Expanded(
        child: Container(
          // width: double.infinity,
          // height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              _getBody(),
              _getBottom(),
            ],
          ),
        ),
      );
    });
  }

  _getBottom() {
    return Column(
      children: [
        Container(height: 1, color: Colors.black),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: true,
              child: Expanded(
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                    },
                    child: Container(
                      height: 42,
                      alignment: Alignment.center,
                      child: Text(
                        "还原",
                        style: TextStyle(  color: Colors.blue,
                          fontSize: 16,),

                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                onPressed: () {
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                      BorderRadius.all(Radius.circular(32.0)),
                    ),
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
                    alignment: Alignment.center,
                    child: Text(
                      "写入",
                      style: TextStyle(
                          color: Colors.white, fontSize: 16),
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _getBody() {
    return Expanded(child: SingleChildScrollView(
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/box_signal.svg",
            height: ViewSizeUtils.getSize(280),
          ),
          Container(
              padding: EdgeInsets.only(top: 24, left: 24),
              width: double.infinity,
              child: Text(
                "智能感应信号强度调整",
                style: TextStyle(
                    color: Color(0Xff2A2A2A),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )),
          Container(
              padding: EdgeInsets.only(top: 38, left: 24, right: 24),
              width: double.infinity,
              child: Text(
                "请放入智能卡至读写线圈",
                style:
                TextStyle(color: Color(0Xff2A2A2A), fontSize: 18),
              )),
          Container(
            padding: EdgeInsets.only(top: 64, left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () {
                    int value = int.parse(_controller.text.isEmpty
                        ? "0"
                        : _controller.value.text);
                    _controller.text = (value - 10).toString();
                  },
                  child: Container(
                    padding: EdgeInsets.all(ViewSizeUtils.getSize(5)),
                    child: SvgPicture.asset(
                      "assets/cut_back.svg",
                      height: ViewSizeUtils.getSize(24),
                    ),
                  ),
                ),
                Container(
                  child: _getInputText(_controller),
                  padding: EdgeInsets.only(
                      left: ViewSizeUtils.getSize(19),
                      right: ViewSizeUtils.getSize(19)),
                ),
                InkWell(
                  onTap: () {
                    int value = int.parse(_controller.text.isEmpty
                        ? "0"
                        : _controller.value.text);
                    _controller.text = (value + 10).toString();
                  },
                  child: Container(
                    padding: EdgeInsets.all(ViewSizeUtils.getSize(5)),
                    child: SvgPicture.asset(
                      "assets/increase.svg",
                      height: ViewSizeUtils.getSize(24),
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
              padding: EdgeInsets.only(top: 24, left: 24, right: 24),
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                "“-”感应距离减小，“+”感应距离增大。",
                style:
                TextStyle(color: Color(0Xff9d9d9d), fontSize: 14),
              )),
          Container(
              height: ViewSizeUtils.getSize(56),
              padding: EdgeInsets.only(top: 16, left: 24, right: 24),
              width: double.infinity,
              child: Text(
                "当遇到智能功能只有在中央扶手处才有或钥匙在车外也能启动车辆时需要调整信号强弱。",
                style:
                TextStyle(color: Color(0Xff9d9d9d), fontSize: 14),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    ));
  }
}

_getInputText(TextEditingController controller) {
  return ConstrainedBox(
    constraints: BoxConstraints(
        maxHeight: ViewSizeUtils.getSize(59),
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
            borderSide: BorderSide(
                color: Color(0xffff0000), style: BorderStyle.none, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(ViewSizeUtils.getSize(16)),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xffff0000), style: BorderStyle.none, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(ViewSizeUtils.getSize(16)),
            ),
          ),

          // 填充颜色属性，填充装饰容器的颜色。
          fillColor: Color(0xfff5f5f5),
          // 填充属性，如果为`true`，则装饰的容器将填充fillColor颜色。
          filled: true,

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
