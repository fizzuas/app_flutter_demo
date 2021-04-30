import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/provider/db_progress.dart';
import 'package:flutter_app/provider/progress.dart';
import 'package:flutter_app/provider/upgrade_Info.dart';
import 'package:flutter_app/route/router.dart';
import 'package:flutter_app/util/f_log.dart';
import 'package:flutter_app/util/view_size_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver();
final GlobalKey<NavigatorState> navigatorState = GlobalKey();
BuildContext appContext;

void main() {
  // Stetho.initialize();
  debugPrint = (String message, {int wrapWidth}) =>debugPrintSynchronously(message, wrapWidth: wrapWidth);

  runApp(new MyAPP());
}

class MyAPP extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyState<MyAPP>();
  }
}

class MyState<MyApp> extends State {
  @override
  void initState() {
    super.initState();
    FLog("debugPrint\tssss\n\n\n dd");
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Progress()),
        ChangeNotifierProvider.value(value: AppProgress()),
        ChangeNotifierProvider.value(value: UpgradeInfo())
      ],
      child: OKToast(
        child: new MaterialApp(
          routes: PagerRouter.routes,
          navigatorKey: navigatorState,
          title: "ss",
          theme: ThemeData(
            pageTransitionsTheme: PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              },
            ),
          ),
          home: new Page(),
          // 路由拦截！
          onGenerateRoute: (RouteSettings settings) {
            final String pageName = settings.name;
            print("pageName=$pageName");
            final Function pageBuilder = PagerRouter.routes[pageName];
            if (settings.arguments != null) {
              return MaterialPageRoute(
                  settings: RouteSettings(name: pageName),
                  builder: (context) =>
                      pageBuilder(context, arguments: settings.arguments));
            } else {
              return MaterialPageRoute(
                  settings: RouteSettings(name: pageName),
                  builder: (context) => pageBuilder(context));
            }
          },
          builder: (BuildContext context, Widget child) {
            /// make sure that loading can be displayed in front of all other widgets
            return Material(
              type: MaterialType.transparency,
              child: FlutterEasyLoading(
                child: child,
              ),
            );
          },
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewSizeUtils().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter 学习"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _getItem(context, "状态管理", PagerRouter.stateManager),
              _getItem(context, "PageView", PagerRouter.pages),
              _getItem(context, "子线程下载", PagerRouter.threadUpdate1),
              _getItem(context, "输入框", PagerRouter.inputText),
              _getItem(context, "定位", PagerRouter.location),
              _getItem(context, "seekbar", PagerRouter.slider),
              _getItem(context, "序列化", PagerRouter.serial),
              _getItem(context, "alert", PagerRouter.alert),
              _getItem(context, "pres列表", PagerRouter.pres),
              _getItem(context, "阴影", PagerRouter.shader),
            ],
          ),
        ),
      ),
    );
  }

  _getItem(BuildContext context, String name, String pushName) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 25),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(pushName);
        },
        child: Container(
          width: ViewSizeUtils.getSize(343),
          height: ViewSizeUtils.getSize(42),
          alignment: Alignment.center,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(0xff, 0x05, 0x7c, 0xff),
            ),
          ),
          decoration: new BoxDecoration(
            //设置四周圆角
            borderRadius: BorderRadius.all(Radius.circular(21)),
            //设置四周边框
            border: new Border.all(
                width: 1, color: Color.fromARGB(0xff, 0x05, 0x7c, 0xff)),
          ),
        ),
      ),
    );
  }
}
