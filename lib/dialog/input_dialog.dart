import 'package:flutter/material.dart';

class DialogInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        color: Colors.black,
        onPressed: () {
          showDeleteConfirmDialog4(context);
        },
      ),
    );
  }
}

StateSetter ss;

Future<bool> showDeleteConfirmDialog4(BuildContext context) {
  var sb = StatefulBuilder(
    builder: (ctx, state) {
      ss = state;
      return Center(
        child: Container(
          height: 180,
          width: 280,
          child: Column(
            children: <Widget>[
              Text("请输入22位兑换券",style: TextStyle(),),
            ],
          ),
        ),
      );
    },
  );
  showDialog(context: context, builder: (ctx) => sb);
}
