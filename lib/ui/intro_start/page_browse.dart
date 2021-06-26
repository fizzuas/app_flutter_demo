import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/route/router.dart';
import 'package:flutter_app/util/f_log.dart';

class AppFuncBrowse extends StatefulWidget {
  @override
  _AppFuncBrowseState createState() {
    return _AppFuncBrowseState();
  }
}

class _AppFuncBrowseState extends State<AppFuncBrowse> {
  PageController _pageController = PageController();
  int _pageIndex = 0;
  GlobalKey<_AppFuncBrowseState> _pageIndicatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Stack(
        children: <Widget>[_createPageView(), _createPageIndicator()],
      ),
    ));
  }

  Widget _createPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (pageIndex) {
        setState(() {
          _pageIndex = pageIndex;
          print(_pageController.page);
          print(pageIndex);
        });
      },
      children: <Widget>[
        Container(
          color: Colors.blue,
          child: Center(
            child: Text('Page 1'),
          ),
        ),
        Container(
          color: Colors.red,
          child: Center(
            child: Text('Page 2'),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(PagerRouter.main);
          },
          child: Container(
            color: Colors.green,
            child: Center(
              child: Text('Page 3'),
            ),
          ),
        ),
      ],
    );
  }

  _createPageIndicator() {
    return Opacity(
      opacity: 0.7,
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 60),
          height: 40,
          width: 80,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: Colors.grey.withAlpha(128),
              borderRadius: BorderRadius.all(const Radius.circular(6.0))),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapUp: (detail) => _handlePageIndicatorTap(detail),
            child: Row(
                key: _pageIndicatorKey,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _dotWidget(0),
                  _dotWidget(1),
                  _dotWidget(2),
                ]),
          ),
        ),
      ),
    );
  }

  _dotWidget(int index) {
    return Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (_pageIndex == index) ? Colors.white70 : Colors.black12));
  }

  _handlePageIndicatorTap(TapUpDetails detail) {
    FLog("切换切换" + detail.toString());
    RenderBox renderBox = _pageIndicatorKey.currentContext.findRenderObject();
    Size widgeSize = renderBox.paintBounds.size;
    Offset tapOffset = renderBox.globalToLocal(detail.globalPosition);
    if (tapOffset.dx > widgeSize.width / 2) {
      _scrollToNextPage();
    } else {
      _scrollToPreviousPage();
    }
  }

  _scrollToPreviousPage() {
    if (_pageIndex > 0) {
      _pageController.animateToPage(_pageIndex - 1,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
    }
  }

  _scrollToNextPage() {
    if (_pageIndex < 3) {
      _pageController.animateToPage(_pageIndex + 1,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
    }
  }
}
