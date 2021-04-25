import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/util/view_size_utils.dart';



class EasyAlert2 {
  // MARK: Show Alert View

  /// 显示一个 Alert 提示框
  ///
  /// [BuildContext] 弹框上下文
  /// [title] 标题
  /// [content] * 弹框描述内容
  /// [showCancel] 是否显示取消按钮
  /// [cancelText] 取消按钮标题
  /// [confirmText] 确定按钮标题
  /// [cancelClicked] 取消按钮点击回调
  /// [confirmClicked] 确定按钮点击回调
  static void show(
    BuildContext context, {
    String title = "",
    @required String content,
    bool showCancel = false,
    String cancelText,
    String confirmText = "OK",
    VoidCallback cancelClicked,
    VoidCallback confirmClicked,
    TextStyle contentStyle,
    bool barrierDismissible = false,
  }) async {
    final titleText = title.isEmpty ? "提示": title;
    var titleView = _EasyAlertExt.makeTitleView(titleText);
    var contentTextView =
        _EasyAlertExt.makeDescriptionView(content, contentStyle: contentStyle);

    final cancel = cancelText.isNullOrEmpty ? "取消" : cancelText;

    var actions = List<Widget>();

    var confirmAction = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(ViewSizeUtils.getSize(50)),
      ),
      margin: EdgeInsets.only(
        top: ViewSizeUtils.getSize(30),
        left: ViewSizeUtils.getSize(20),
        right: ViewSizeUtils.getSize(20),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ViewSizeUtils.getSize(50))),
        child: _EasyAlertExt.makeButtonTextView(confirmText),
        onPressed: () {
          Navigator.of(context).pop();
          confirmClicked?.call();
        },
      ),
    );
    actions.add(confirmAction);
    if (showCancel) {
      var cancelAction = Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF4F4F4),
          borderRadius: BorderRadius.circular(ViewSizeUtils.getSize(50)),
        ),
        margin: EdgeInsets.only(
          top: ViewSizeUtils.getSize(30),
          left: ViewSizeUtils.getSize(20),
          right: ViewSizeUtils.getSize(20),
        ),
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ViewSizeUtils.getSize(50))),
          child: _EasyAlertExt.makeButtonTextView(cancel, isCancel: true),
          onPressed: () {
            Navigator.of(context).pop();
            cancelClicked?.call();
          },
        ),
      );
      actions.add(cancelAction);
    }
    var contentView = [
      titleView,
      contentTextView,
      SizedBox(height: 8 * 1.5),
      // Divider(height: 2, color: Color(0xFFDDDDDD)),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: actions,
      ),
    ];
    var simpleDialog =
    WillPopScope(child: Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(
            top: ViewSizeUtils.getSize(16),
            left: ViewSizeUtils.getSize(16),
            right: ViewSizeUtils.getSize(16),
            bottom: ViewSizeUtils.getSize(56)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ViewSizeUtils.getSize(12)),
              topRight: Radius.circular(ViewSizeUtils.getSize(12))),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: contentView,
          ),
        ),
      ),
    ), onWillPop:  () async => false);

     showDialog<bool>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => simpleDialog);
  }
}

extension _EasyAlertExt on EasyAlert2 {
  static const double kTitleFontSize = 20;
  static const double kContentFontSize = 15;
  static const double kButtonFontSize = 16;

  static Widget makeTitleView(String title) {
    return _makeTextView(text: title, style: _titleStyle);
  }

  static Widget makeDescriptionView(String description,
      {TextStyle contentStyle = _contentStyle}) {
    return _makeTextView(text: description, style: contentStyle);
  }

  static Widget makeButtonTextView(String title, {bool isCancel = false}) {
    return _makeTextView(
        text: title,
        style: TextStyle(
            fontSize: kButtonFontSize,
            color: isCancel ? Color(0xFFBABABA) : Color(0xFF616161)));
  }

  static Widget _makeTextView({String text, TextStyle style}) {
    if (text == null || text.isEmpty) {
      return Container();
    }
    return Container(
        child: Text(text, textAlign: TextAlign.center, style: style),
        padding: EdgeInsets.symmetric(vertical: ViewSizeUtils.getSize(16)));
  }

  static TextStyle get _titleStyle => TextStyle(
      color: ColorCommon.dark,
      fontSize: kTitleFontSize,
      fontWeight: FontWeight.bold);

  static const _contentStyle = TextStyle(color: ColorCommon.grey, fontSize: 16);

  static TextStyle get _buttonStyle => TextStyle(fontSize: kButtonFontSize);
}

class ColorCommon {
  static const Color dark = Colors.black45;
  static const Color grey = Colors.grey;
}

extension StringExtension on String {
  bool get isNullOrEmpty => (this == null || this.isEmpty);
  bool get isNotNullOrEmpty => (this != null && this.isNotEmpty);
}
