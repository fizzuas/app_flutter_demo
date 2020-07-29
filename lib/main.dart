import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'Tabs.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new RandomWords();
  }
}

class RandomWords extends StatefulWidget {
  RandomWords({Key key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  var wordPair = new WordPair.random();
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  List widgets =[];

  @override
  void initState() {
    super.initState();
    _suggestions.addAll(generateWordPairs().take(5));
    widgets.add(getRow(0));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('My app'),
        ),
        body: _buildSuggestions(),
      ),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      itemCount: 2*widgets.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      },
      itemExtent: 50,
    );
  }

  Widget getRow(int i) {
    if(i.isOdd){
      return new Divider();
    }else{
      return new GestureDetector(
        child: new Container(
          child:  Text.rich(
            TextSpan(
              // 必须设置一个父TextStyle 否则 字体是白色
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                text: "Text.rich 实现：      ",
//                children: <TextSpan>[
//                  TextSpan(
//                      text: '绚丽',
//                      style: TextStyle(
//                          color: Colors.red,
//                          fontWeight: FontWeight.normal)),
//                  TextSpan(
//                      text: '文本',
//                      style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        color: Colors.blue,
//                      )),
//                  TextSpan(
//                      text: '样式',
//                      style: TextStyle(
//                          fontStyle: FontStyle.italic,
//                          color: Colors.black,
//                          fontSize: 18,
//                          decoration: TextDecoration.lineThrough,
//                          fontWeight: FontWeight.normal)),
//                ]
            ),
            style: TextStyle(height: 2),
          ),



        ),
        onTap: (){
          setState(() {
            widgets.add(getRow(widgets.length + 1));
            print('row $i');
          });
        },
      );
    }

  }
}
