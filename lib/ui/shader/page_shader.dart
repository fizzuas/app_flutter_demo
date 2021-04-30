
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/base/_base_widget.dart';
import 'package:flutter_app/ui/title/common_titleview.dart';

class PageShader extends StatefulWidget {
  @override
  _PageShaderState createState() => _PageShaderState();
}

class _PageShaderState extends BaseWidgetState<PageShader> {

  @override
  void initData() {
  }

  @override

  Widget initTitleView() {
    return CommonTitleView(titleName:"SHADER");
  }

  @override
  Widget setPageLayout(BuildContext context) {
   return _getHeaderShadow();
  }

  //阴影
  Widget _getHeaderShadow() {
    return IgnorePointer(
      ignoring: true,
      child: AspectRatio(
        aspectRatio: 1.339,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0x80000000),
                Color(0x00FFFFFF),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
}
