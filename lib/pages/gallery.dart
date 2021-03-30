import 'package:flutter/material.dart';
import 'editor.dart';

class Gallery extends StatelessWidget {
  List<Widget> _getImages(BuildContext context) {
    List<Widget> listImages = <Widget>[];

    var images = {
      'dash': Image.asset('images/dash.jpg'),
      'dash1': Image.asset('images/dash1.jpg'),
      'dash2': Image.asset('images/dash2.jpeg'),
      'dash3': Image.asset('images/dash3.png'),
    };
    var nav = (Image image) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Editor(image: image),
        ),
      );
    };
    for (var i = 0; i < 12; i++) {
      ElevatedButton dash = ElevatedButton(
        child: images['dash'],
        onPressed: () => nav(images['dash']),
      );
      ElevatedButton dash1 = ElevatedButton(
        child: images['dash1'],
        onPressed: () => nav(images['dash1']),
      );
      ElevatedButton dash2 = ElevatedButton(
        child: images['dash2'],
        onPressed: () => nav(images['dash2']),
      );
      ElevatedButton dash3 = ElevatedButton(
        child: images['dash2'],
        onPressed: () => nav(images['dash23']),
      );

      listImages.add(dash);
      listImages.add(dash1);
      listImages.add(dash2);
      listImages.add(dash3);
    }

    return listImages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Photos'),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: GridView.count(
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: _getImages(context),
        ),
      ),
    );
  }
}
