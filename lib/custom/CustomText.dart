import 'dart:math';

import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  @override
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  void initState() {
    super.initState();

  }

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

  Paint _paintLine = new Paint()
    ..color = Colors.black
    ..isAntiAlias = true;

  Paint keyPaint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.fill
    ..color = Color(0xFFEEEEEE);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), _paint);

    canvas.drawLine(Offset(50, 0), Offset(50, 50), _paintLine);

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 30,
    );
    final textSpan = TextSpan(
      text: 'A',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    print("text height" + textPainter.height.toString());
    final offset =
        Offset(50 - textPainter.width / 2, 50 - textPainter.height / 2);
    textPainter.paint(canvas, offset);

    // 旋转
    canvas.drawLine(Offset(100, 0), Offset(100, 50), _paintLine);
    canvas.save();
    canvas.translate(100, 50);
    canvas.rotate(-pi / 2);
    textPainter.paint(
        canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
    canvas.restore();

    _drawLocatePoint(canvas, size, Offset(50, 50));
  }

  //画定位点的箭头
  void _drawLocatePoint(Canvas canvas, Size size, Offset center) {
    keyPaint.strokeWidth = 1.5;
    canvas.drawLine(Offset(center.dx, center.dy),
        Offset(center.dx, center.dy - 14), keyPaint);
    canvas.drawLine(Offset(center.dx, center.dy),
        Offset(center.dx - 2, center.dy - 4), keyPaint);
    canvas.drawLine(Offset(center.dx, center.dy),
        Offset(center.dx + 2, center.dy - 4), keyPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
