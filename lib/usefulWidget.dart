import 'dart:math';

import 'package:flutter/material.dart';

class TriangleDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('RowDemo')),
        body: CustomPaint(
            painter: TriangleWidget(
                context,
                [
                  [10, 0],
                  [0, 42],
                  [135, 42],
                  [135, 0],
                ],
                color: Color(0xffC0C4CC))));
  }
}

class TriangleWidget extends CustomPainter {
  Paint _paint = new Paint(); //画笔富含各种属性方法。仔细查看源码
  final BuildContext context;
  final List<List<double>> spots;
  final Color color;

  TriangleWidget(this.context, this.spots, {this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Path path = new Path()..moveTo(spots[0][0], spots[0][1]);
    path.lineTo(spots[1][0], spots[1][1]);
    path.lineTo(spots[2][0], spots[2][1]);
    path.lineTo(spots[3][0], spots[3][1]);
    canvas.drawPath(
        path,
        _paint
          ..style = PaintingStyle.fill
          ..color = color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
