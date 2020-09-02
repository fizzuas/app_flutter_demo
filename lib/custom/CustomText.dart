import 'dart:math';

import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  @override
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: RepaintBoundary(
      child: CustomPaint(
        painter: TextPaint(),
        size: Size(300, 300),
      ),
    ));
  }
}

class TextPaint extends CustomPainter {
  Paint _paint = new Paint()
    ..color = Colors.grey
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), _paint);
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 30,
    );
    final textSpan = TextSpan(
      text: 'Hello, world.',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    canvas.save();
    print("text height"+textPainter.height.toString());
    canvas.translate(textPainter.height/2, 0);
    canvas.rotate(pi / 2);
    final offset = Offset(0, 0);
    textPainter.paint(canvas, offset);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
