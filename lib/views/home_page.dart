import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/mixins/portraitmode_mixin.dart';
import 'package:mediatrack_flutter/views/home.dart';
import 'package:mediatrack_flutter/views/movie/movies_screen.dart';
import 'package:mediatrack_flutter/views/profile.dart';
import 'package:mediatrack_flutter/views/tvshow/tvshow_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with PortraitStatefulModeMixin {
  int _currentTab = 0;

  List<Widget> _children = [
    HomeScreen(),
    MoviesScreen(),
    TVShowScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentTab,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.grey,
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
