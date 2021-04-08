import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Editor extends StatefulWidget {
  Editor({@required this.image});

  final Image image;

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  double _opacityValue = 1.0;
  double _blurValue = 0;
  bool _activedOpacity = false;
  bool _activedBlur = false;
  bool _activedPaint = false;
  double _visibleSliderOpacity = 0;
  double _visibleSliderBlur = 0;
  List<Offset> _offsets;
  GlobalKey _paintKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _offsets = <Offset>[];
  }

  void _activeOpacity() {
    _activedOpacity = !_activedOpacity;
    setState(() {
      _visibleSliderOpacity = _activedOpacity ? 1 : 0;
    });
  }

  void _activeBlur() {
    _activedBlur = !_activedBlur;
    setState(() {
      _visibleSliderBlur = _activedBlur ? 1 : 0;
    });
  }

  void _activePaint() {
    setState(() {
      _activedPaint = !_activedPaint;
    });
  }

  void _changeOpacity(newValue) {
    setState(() {
      _opacityValue = newValue;
    });
  }

  void _changeBlur(newValue) {
    setState(() {
      _blurValue = newValue;
    });
  }

  void _paint(PointerMoveEvent event) {
    RenderBox referenceBox = _paintKey.currentContext.findRenderObject();
    Offset offset = referenceBox.globalToLocal(event.position);
    setState(() {
      _offsets.add(offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Opacity(
            opacity: _opacityValue,
            child: widget.image,
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: _blurValue, sigmaY: _blurValue),
            child: Container(color: Colors.white.withOpacity(0.0)),
          ),
          _activedPaint
              ? Listener(
                  onPointerMove: _paint,
                  child: CustomPaint(
                    key: _paintKey,
                    painter: PaintPoint(offsets: _offsets),
                    child: Container(),
                  ),
                )
              : AbsorbPointer(
                  child: Listener(
                    onPointerMove: _paint,
                    child: CustomPaint(
                      key: _paintKey,
                      painter: PaintPoint(offsets: _offsets),
                      child: Container(),
                    ),
                  ),
                ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Opacity(
              opacity: _visibleSliderOpacity,
              child: _activedOpacity
                  ? Slider(
                      min: 0,
                      max: 1,
                      value: _opacityValue,
                      onChanged: _changeOpacity)
                  : AbsorbPointer(
                      child: Slider(
                          min: 0,
                          max: 1,
                          value: _opacityValue,
                          onChanged: _changeOpacity)),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Opacity(
              opacity: _visibleSliderBlur,
              child: _activedBlur
                  ? Slider(
                      min: 0,
                      max: 10,
                      value: _blurValue,
                      onChanged: _changeBlur)
                  : AbsorbPointer(
                      child: Slider(
                          min: 0,
                          max: 10,
                          value: _blurValue,
                          onChanged: _changeBlur)),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(top: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 15, left: 10),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.opacity),
                  label: Text('Opacity'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: _activeOpacity, //_applyEffectOpacity,
                )),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ElevatedButton.icon(
                icon: Icon(Icons.blur_on),
                label: Text('Blur'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: _activeBlur, //_applyEffectBlur,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.format_paint_outlined),
                label: Text('Paint'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: _activePaint, //_applyEffectBlur,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaintPoint extends CustomPainter {
  PaintPoint({this.offsets});

  List<Offset> offsets;

  @override
  void paint(Canvas canvas, Size size) {
    if (this.offsets.isEmpty) return;

    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.square;
    for (Offset x in offsets) {
      canvas.drawLine(x, x, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
