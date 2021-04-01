import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<MyButton> {
  double _value = 1;
  double _opacityValue = 0;
  bool visible = false;

  // List<Widget> _widgets;
  @override
  void initState() {
    super.initState();
    // _widgets = <Widget>[
    //   Image.asset('images/dash.jpg'),
    //   ElevatedButton.icon(
    //     onPressed: _addSlider,
    //     icon: Icon(Icons.ac_unit),
    //     label: Text('Press on'),
    //   )
    // ];
  }

  // void _addSlider() {
  //   setState(() {
  //     this._widgets.add(MySlider());
  //   });
  // }

  void _onPressed() {
    visible = !visible ? true : false;
    setState(() {
      _opacityValue = visible ? 1 : 0;
    });
  }

  void _onChanged(newValue) {
    setState(() {
      _value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: _value,
            child: Image.asset('images/dash.jpg'),
          ),
          Positioned(
            top: 50,
            child: ElevatedButton.icon(
              onPressed: _onPressed,
              label: Text('Press on me'),
              icon: Icon(Icons.ac_unit),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Opacity(
                opacity: _opacityValue,
                child: Slider(
                  min: 0,
                  max: 1,
                  value: _value,
                  onChanged: _onChanged,
                )),
          ),
        ],
      ),
    );
  }
}

class MySlider extends StatefulWidget {
  @override
  SliderState createState() => SliderState();
}

class SliderState extends State<MySlider> {
  double _value = 0.5;

  void _changeValueSlider(newValue) {
    setState(() {
      _value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0,
      max: 1,
      value: _value,
      onChanged: (newValue) => _changeValueSlider(newValue),
    );
  }
}
