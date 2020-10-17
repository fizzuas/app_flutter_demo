import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart';

class MyListView extends StatefulWidget {
  MyListView({Key key}) : super(key: key);

  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List _suggestions = [];
  List _widgets = [];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    // _suggestions.addAll(generateWordPairs().take(5));
    _widgets.add(_buildRow(0));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('My app'),
        ),
        body: _buildSuggestions(_suggestions),
      ),
    );
  }

  Widget _buildSuggestions(List list) {
    return new ListView.builder(
      itemCount: 2 * list.length,
      itemBuilder: (BuildContext context, int position) {
        return _buildRow2(list,position);
      },
    );
  }

  Widget _buildRow(int i) {
    if (i.isOdd) {
      return new Divider(height: 1,);
    } else {
      i=i~/2;
      return new GestureDetector(
        child: new Container(
          height: 50,
          decoration: ShapeDecoration(color: Colors.grey,shape: Border()),
          alignment: Alignment.center,
          child: Text.rich(
            TextSpan(
              // 必须设置一个父TextStyle 否则 字体是白色
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              text: "row$i",
            ),
            style: TextStyle(height: 2),
          ),
        ),
        onTap: () {
          setState(() {
            _widgets.add(_buildRow(_widgets.length + 1));
            print('row $i');
          });
        },
      );
    }
  }

  Widget _buildRow2(List list,int i) {
    if(i.isOdd){
      return new Divider(height: 1,);
    }else{
      i=i~/2;
      if (i>= list.length) {
        // ...接着再生成10个单词对，然后添加到建议列表
        setState(() {
          // list.addAll(generateWordPairs().take(10));

        });
      }
      return new ListTile(
      title: Text("row $i"),

      );
    }

  }
}
