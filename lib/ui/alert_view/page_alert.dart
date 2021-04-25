import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/base/_base_widget.dart';
import 'package:flutter_app/ui/alert_view/easy_alert2.dart';
import 'package:flutter_app/ui/title/common_titleview.dart';

class PageAlert extends StatefulWidget {
  @override
  _PageAlertState createState() => _PageAlertState();
}

class _PageAlertState extends BaseWidgetState<PageAlert> {
  @override
  void initData() {
    print("initData");
    // _check();
  }

  @override
  Widget initTitleView() {
    return CommonTitleView(titleName: "alert");
  }

  @override
  Widget setPageLayout(BuildContext context) {
    return Column(
      children: [
        FlatButton(
            onPressed: () async {
              _check();
            },
            child: Text("弹框"))
      ],
    );
  }

  _check() {
    EasyAlert2.show(context,
        content: "xxxx",
        showCancel: true,
        cancelClicked: () {},
        confirmClicked: () {});
  }
}
