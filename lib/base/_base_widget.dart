import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../main.dart';

//flutter packages pub run build_runner build --delete-conflicting-outputs
abstract class BaseWidgetState<T extends StatefulWidget> extends State<T>
    with RouteAware {
  @override
  void initState() {
    print(" BaseWidgetState=${this.context.widget}");
    super.initState();
    initData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPopNext() {
    print(this.toString() + "=didPopNext");
    super.didPopNext();
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss(animation: false);
    routeObserver.unsubscribe(this);
  }

  void initData(); //加载数据库，初始化蓝牙、网络框架等的东西

  Widget initTitleView(); //初始化自定义头部布局

  Widget setPageLayout(BuildContext context); //初始化页面body布局

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: initTitleView(),
      body: SafeArea(
          child: Column(
        children: [
          setPageLayout(context),
        ],
      )),
      // resizeToAvoidBottomPadding: false,
    ));
  }
}
