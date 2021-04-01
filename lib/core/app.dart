import 'package:flutter/material.dart';
import 'package:imageeditorapp/pages/gallery.dart';
//import 'package:imageeditorapp/pages/state_test.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Editor',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryTextTheme:
            Theme.of(context).primaryTextTheme.apply(bodyColor: Colors.white),
      ),
      home: Gallery(),
    );
  }
}
