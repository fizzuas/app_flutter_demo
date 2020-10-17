import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/_base_widget.dart';
import 'package:flutter_app/ui/title/common_titleview.dart';
import 'package:flutter_app/util/view_size_utils.dart';

import 'BusinessNewPage.dart';
import 'HomePage.dart';
import 'MePage.dart';
import 'bean_home_menu.dart';

class HomePager extends StatefulWidget {
  @override
  _HomePagerState createState() => _HomePagerState();
}

class _HomePagerState extends State<HomePager> {
  final _pages = [HomePage(), BusinessNewPage(), MePage()];
  final tabs = [
    HomeMenuBean("home", "images/icon_home.png"),
    HomeMenuBean("store", "images/icon_store.png"),
    HomeMenuBean("me", "images/icon_me.png"),
  ];
  PageController _controll;
  int _currentIndex=0;

  @override
  void initState() {
    super.initState();
    _controll = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _getBottomNavigationBar(),
      body: PageView.builder(
        itemBuilder: (context, index) {
          return _pages[index];
        },
        itemCount: _pages.length,
        controller: _controll,
        physics: NeverScrollableScrollPhysics(),
        // onPageChanged: (value){
        //   print(value);
        //   if(value==2&&_pages[2]!=null){
        //     setState(() {
        //     });
        //   }
        // },
      ),
    );
  }

  Widget _getBottomNavigationBar() {
    return CupertinoTabBar(
      items: List.generate(tabs.length, (index) {
        return BottomNavigationBarItem(
          title: Text(
            tabs[index].menuName,
            style: TextStyle(
              fontSize: ViewSizeUtils.setSp(12),
            ),
          ),
          icon: Container(
            margin: EdgeInsets.only(top: ViewSizeUtils.getSize(3)),
            child: Image.asset(
              tabs[index].menuIcon,
              color: _currentIndex == index ? Colors.blue : Color(0xFF616161),
              width: ViewSizeUtils.getSize(22),
              height: ViewSizeUtils.getSize(22),
            ),
          ),
        );
      }),
      backgroundColor: Colors.white,
      currentIndex: _currentIndex,
      border: Border(top: BorderSide(color: Colors.transparent)),
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          _controll?.jumpToPage(index);
        });
      },
    );
  }
}
