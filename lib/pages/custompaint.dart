import 'package:flutter/material.dart';

class DrawPoint extends StatefulWidget {
  @override
  DrawPointState createState() => DrawPointState();
}

class DrawPointState extends State<DrawPoint> {
  List<Offset> _offset;
  GlobalKey _paintKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _offset = <Offset>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        onPointerMove: (PointerMoveEvent event) {
          RenderBox referenceBox = _paintKey.currentContext.findRenderObject();
          Offset offset = referenceBox.globalToLocal(event.position);
          setState(() {
            _offset.add(offset);
          });
        },
        child: CustomPaint(
          key: _paintKey,
          painter: PaintPoint(offset: _offset),
          child: Container(),
        ),
      ),
    );
  }
}

class PaintPoint extends CustomPainter {
  PaintPoint({this.offset});

  List<Offset> offset;

  @override
  void paint(Canvas canvas, Size size) {
    if (this.offset.isEmpty) return;

    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.square;
    for (Offset x in offset) {
      canvas.drawLine(x, x, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
