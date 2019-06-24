import 'dart:async';
import 'package:flutter/material.dart';
import './pages/splash_screen.dart';
import './ui-elements/home.dart';
import './pages/rangoli_images_screen.dart';
import './pages/rangoli_pageview.dart';

StreamController stream;
void main() {
  runApp(new RangoliApp());
}

class RangoliApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RangoliAppState();
  }
}

class _RangoliAppState extends State<RangoliApp> {
//static final List<Section> sections = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rangoli Designs',
      theme: new ThemeData(primarySwatch: Colors.indigo),
      routes: {
        '/': (BuildContext context) => HomeScreen(),
        // '/rangoliCategory': (BuildContext context) {
        //   return AnimationDemoHome();
        // },
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'rangoliImages') {
          String category = pathElements[2];
          return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  RangoliImages(category: category));
        } else if (pathElements[1] == 'rangoli') {
          List<String> pathElementsForImage =
              settings.name.split('rangoli/image/');
          String category = pathElementsForImage[1].split('/')[0];
          int index = int.parse(pathElementsForImage[1].split('/')[1]);
          return MaterialPageRoute<bool>(
              builder: (BuildContext context) => RangoliPageView(
                    category: category,
                    imageIndex: index,
                  ));
        }
        return null;
      },
    );
  }
}
