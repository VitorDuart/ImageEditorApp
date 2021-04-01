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
  double _visibleSliderOpacity = 0;
  double _visibleSliderBlur = 0;

  void _activeOpacity() {
    _activedOpacity = !_activedOpacity ? true : false;
    setState(() {
      _visibleSliderOpacity = _activedOpacity ? 1 : 0;
    });
  }

  void _activeBlur() {
    _activedBlur = !_activedBlur ? true : false;
    setState(() {
      _visibleSliderBlur = _activedBlur ? 1 : 0;
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
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(top: 10.0),
        child: Row(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20),
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
                padding: const EdgeInsets.only(right: 20),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.blur_on),
                  label: Text('Blur'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: _activeBlur, //_applyEffectBlur,
                )),
          ],
        ),
      ),
    );
  }
}
