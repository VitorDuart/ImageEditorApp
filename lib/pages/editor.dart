import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Editor extends StatefulWidget {
  Image image;

  Editor({@required this.image});

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  double _value = 1.0;
  List<Widget> _widgetBody;
  final int _indexSlider = 1;
  Slider _opacitySlider;

  @override
  void initState() {
    super.initState();
    _widgetBody = <Widget>[
      Opacity(
        opacity: _value,
        child: widget.image,
      ),
    ];
    _opacitySlider = Slider(
      value: _value,
      onChanged: (double newValue) {
        setState(() {
          _value = newValue;
        });
      },
      min: 0.0,
      max: 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _widgetBody,
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  if (this._widgetBody.length == _indexSlider)
                    this._widgetBody.add(_opacitySlider);
                  else
                    this._opacitySlider =
                        this._widgetBody.removeAt(_indexSlider);
                });
              },
              icon: Icon(Icons.opacity),
              label: Text('Opacity'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
