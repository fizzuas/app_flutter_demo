//
// easy_alert.dart
// KYSuperApp
//
// Created by 曹雪松 on 2020/8/5.
// Copyright © 2020 KYDW. All rights reserved.
//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/util/view_size_utils.dart';
import 'package:flutter_app/extension/null_safe_extension.dart';




import '../../main.dart';
const double kCommonMargin = 10;
const double kCornerRadius = 10;

class EasyAlert {

  // MARK: Public Method

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
  static void show(BuildContext context, {
    String title = "",
    @required String content,
    bool showCancel = false,
    String cancelText,
    String confirmText = "OK",
    VoidCallback cancelClicked,
    VoidCallback confirmClicked,
  }) {
    final titleText = title.isEmpty ? "commonNotice" : title;
    var titleView = _EasyAlertExt.makeTitleView(titleText);
    var contentTextView = _EasyAlertExt.makeDescriptionView(content);

    final cancel = cancelText.isNullOrEmpty ? "取消" : cancelText;

    var actions = List<Widget>();
    if (showCancel) {
      var cancelAction = Expanded(
        child: FlatButton(
          child: _EasyAlertExt.makeButtonTextView(cancel),
          textColor: Colors.grey,
          onPressed: () {
            Navigator.of(context).pop();
            cancelClicked?.call();
          },
        ),
      );
      actions.add(cancelAction);
    }
    var confirmAction = Expanded(
      child: FlatButton(
        child: _EasyAlertExt.makeButtonTextView(confirmText),
        textColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).pop();
          confirmClicked?.call();
        },
      ),
    );
    actions.add(confirmAction);

    var contentView = [
      contentTextView,
      SizedBox(height: kCommonMargin * 1.5),
      Divider(height: 2, color: Color(0xFFDDDDDD)),
      Container(
        height: 40,
        child: Row(
          mainAxisAlignment: actions.length > 1 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
          children: actions,
        ),
      )
    ];

    var simpleDialog = SimpleDialog(
      title: titleView,
      titlePadding: EdgeInsets.fromLTRB(kCommonMargin, kCommonMargin * 1.5, kCommonMargin, 0.0),
      children: contentView,
      contentPadding: EdgeInsets.fromLTRB(kCommonMargin * 2, kCommonMargin, kCommonMargin * 2, kCommonMargin),
      shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(kCornerRadius))
      ),
    );
    showDialog(context: context, barrierDismissible: false, builder: (context) => simpleDialog);
  }

  /// 是否已经移除
  static var _hasPopped = false;

  /// 显示一个 Alert 提示框
  ///
  /// [returnable] 是否屏蔽物理返回按钮事件，设置 false 则物理返回按钮无效
  /// [BuildContext] 弹框上下文
  /// [description]  弹框描述内容
  /// [cancelText] 取消按钮标题，默认会显示取消按钮
  /// [confirmText] 确定按钮标题
  /// [cancelClicked] 取消按钮点击回调
  /// [confirmClicked] 确定按钮点击回调
  static Future<void> showLoading(BuildContext context, {
    returnable = true,
    String description,
    String cancelText,
    String confirmText,
    VoidCallback cancelClicked,
    VoidCallback confirmClicked,
  }) async {
    _hasPopped = false;

    var descriptionView = _EasyAlertExt.makeDescriptionView(description);

    var indicatorView = Container(
      width: ViewSizeUtils.getSize(40.0),
      height: ViewSizeUtils.getSize(40.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );

    final cancelTitle = cancelText ?? "cancel";

    var actions = List<Widget>();
    var cancelAction = Expanded(
      child: FlatButton(
        child: _EasyAlertExt.makeButtonTextView(cancelTitle),
        textColor: Colors.grey,
        onPressed: () {
          Navigator.of(context).pop(true);
          cancelClicked?.call();
        },
      ),
    );
    actions.add(cancelAction);

    if (confirmText.isNotNullOrEmpty) {
      var confirmAction = Expanded(
        child: FlatButton(
          child: _EasyAlertExt.makeButtonTextView(confirmText),
          textColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).pop(true);
            confirmClicked?.call();
          },
        ),
      );
      actions.add(confirmAction);
    }

    var contentView = [
      SizedBox(height: kCommonMargin * 1.5),
      indicatorView,
      SizedBox(height: kCommonMargin * 1.5),
      descriptionView,
      SizedBox(height: kCommonMargin * 1.5),
      Divider(height: 2, color: Color(0xFFDDDDDD)),
      Container(
        height: 40,
        child: Row(
          mainAxisAlignment: actions.length > 1 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
          children: actions,
        ),
      )
    ];

    var simpleDialog = SimpleDialog(
      titlePadding: EdgeInsets.fromLTRB(kCommonMargin, kCommonMargin * 1.5, kCommonMargin, 0.0),
      children: contentView,
      contentPadding: EdgeInsets.fromLTRB(kCommonMargin * 2, kCommonMargin, kCommonMargin * 2, kCommonMargin),
      shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(kCornerRadius))
      ),
    );
    _hasPopped = await showDialog(context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
            child: simpleDialog,
            onWillPop: () async {
              return Future.value(returnable);
            }
        )
    );
  }

  /// 弹框是否正在显示
  static get isShowing => !_hasPopped;

  /// 移除弹框
  ///
  /// 注意，如果是在页面的dispose方法中，请将fromDispose参数设置true; 防止页面会被pop两次的问题。
  static void dismiss({bool fromDispose = false}) {
    if (_hasPopped) { return; }
    if (fromDispose) { return; }
    Navigator.of(navigatorState.currentState.overlay.context).pop(true);
  }
}

extension _EasyAlertExt on EasyAlert {
  static const double kTitleFontSize = 17;
  static const double kContentFontSize = 15;
  static const double kButtonFontSize = 16;

  static Widget makeTitleView(String title) {
    return _makeTextView(text: title, style: _titleStyle);
  }

  static Widget makeDescriptionView(String description) {
    return _makeTextView(text: description, style: _contentStyle);
  }

  static Widget makeButtonTextView(String title) {
    return _makeTextView(text: title, style: _buttonStyle);
  }

  static Widget _makeTextView({String text, TextStyle style}) {
    if (text.isNullOrEmpty) { return Container(); }
    return Text(text, textAlign: TextAlign.center, style: style);
  }


  static TextStyle get _titleStyle =>
      TextStyle(color: Colors.black45, fontSize: kTitleFontSize);

  static TextStyle get _contentStyle =>
      TextStyle(color: Colors.grey, fontSize: kContentFontSize);

  static TextStyle get _buttonStyle =>
      TextStyle(fontSize: kButtonFontSize);
}
