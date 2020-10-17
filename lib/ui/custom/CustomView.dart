import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart' as ui2;
import 'package:flutter/services.dart' as ui2;
import 'package:flutter/widgets.dart' as ui2;
import 'package:flutter/material.dart' as ui2;
import 'package:flutter/painting.dart' as u2;

import 'package:flutter/services.dart';

class CustomView extends StatefulWidget {
  @override
  _CustomViewState createState() => _CustomViewState();
}

class _CustomViewState extends State<CustomView> {
  ui.Image img;

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   getImage("images/lake.jpg").then((value) => img);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "cus",
      home: Scaffold(
        appBar: AppBar(
          title: Text("my title"),
        ),
        body: RepaintBoundary(
          child: FutureBuilder<ui.Image>(
              future: getImage("images/img.jpg"),
              builder: (context, snapshot) =>
                  CustomPaint(painter: _F021Paint(snapshot.data))),
        ),
      ),
    );
  }

  Future<ui.Image> getImage(String asset) async {
      ByteData data = await rootBundle.load(asset);
      ui.Codec codec = await ui.instantiateImageCodec(
          data.buffer.asUint8List());
      FrameInfo fi = await codec.getNextFrame();
      return fi.image;
  }
}

class _F021Paint extends CustomPainter {
  Paint _paint = new Paint()
    ..color = Colors.lightBlue;
  ui.Image img;

  _F021Paint(this.img);

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawLine(Offset(0, 0), Offset(100, 100), _paint);
    // canvas.drawColor(Colors.black,BlendMode.colorBurn);
    print("img==null" + (img == null).toString());
    if (img != null) {
      Rect src = Rect.fromLTWH(
          0, 0, img.width.toDouble(), img.height.toDouble());
      Rect dest = Rect.fromLTWH(0, 0, 357, 63);
      canvas.drawImageRect(img, src, dest, _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// class ImageLoader {
//   static ui2.AssetBundle getAssetBundle() => (ui2.rootBundle != null)
//       ? ui2.rootBundle
//       : new ui2.NetworkAssetBundle(new Uri.directory(Uri.base.origin));
//
//   static Future<ui.Image> load(String url) async {
//     ui2.ImageStream stream = new ui2.AssetImage(url, bundle: getAssetBundle())
//         .resolve(ui2.ImageConfiguration.empty);
//     Completer<ui.Image> completer = new Completer<ui.Image>();
//     void listener(ui2.ImageInfo frame, bool synchronousCall) {
//       final ui.Image image = frame.image;
//       completer.complete(image);
//       stream.removeListener(listener);
//     }
//
//     stream.addListener(listener);
//     return completer.future;
//   }
// }
