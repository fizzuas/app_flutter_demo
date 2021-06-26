import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/provider/db_progress.dart';
import 'package:flutter_app/provider/progress.dart';
import 'package:flutter_app/provider/upgrade_Info.dart';
import 'package:flutter_app/route/router.dart';
import 'package:flutter_app/ui/intro/PageIntro.dart';
import 'package:flutter_app/ui/intro_start/page_browse.dart';
import 'package:flutter_app/ui/page_main.dart';
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
          home: new AppFuncBrowse(),
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


