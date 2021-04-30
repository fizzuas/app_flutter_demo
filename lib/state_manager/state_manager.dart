
import 'package:flutter/material.dart';
import 'package:flutter_app/base/_base_widget.dart';
import 'package:flutter_app/ui/title/common_titleview.dart';

class StateManager extends StatefulWidget {
  @override
  _StateManagerState createState() => _StateManagerState();
}

class _StateManagerState extends BaseWidgetState<StateManager> {
  int _count = 0;

  @override
  void initData() {}

  @override
  Widget initTitleView() {
    return new CommonTitleView(titleName: "ss");
  }

  @override
  Widget setPageLayout(BuildContext context) {
    return Column(
      children: [
        Text("current data : $_count"),
        FlatButton(
            onPressed: () {
              setState(() {
                _count = _count + 1;
              });
            },
            child: Text("+"))
      ],
    );
  }
}
