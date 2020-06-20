import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/views/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MediaTrack',
      theme: ThemeData(
        // brightness: Brightness.dark,
        // scaffoldBackgroundColor: Color(0xefffffff),
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'MediaTrack'),
    );
  }
}
