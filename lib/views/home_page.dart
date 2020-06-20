import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediatrack_flutter/views/home.dart';
import 'package:mediatrack_flutter/views/movies.dart';
import 'package:mediatrack_flutter/views/profile.dart';
import 'package:mediatrack_flutter/views/tv.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTab = 0;

  List<Widget> _children = [
    Home(),
    Movies(),
    TV(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('Movies'),
            icon: Icon(
              Icons.movie,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('TV Shows'),
            icon: Icon(
              Icons.tv,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('Profile'),
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
        currentIndex: _currentTab,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            _currentTab = value;
          });
        },
      ),
      body: _children[_currentTab],
    );
  }
}
