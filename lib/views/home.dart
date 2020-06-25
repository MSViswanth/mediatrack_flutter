import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediatrack_flutter/components/horizontal_list.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/movie.dart';
import 'package:mediatrack_flutter/providers/movies_provider.dart';
import 'package:mediatrack_flutter/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MoviesProvider moviesProvider = Provider.of<MoviesProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    bool isWaiting = moviesProvider.isWaiting;
    List<Movie> popularMovies = moviesProvider.trendingMovies;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {},
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 60, 20),
              child: Text(
                'Welcome, ${settingsProvider.getUserName()}. What do you want to watch?',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Text(
                'Trending',
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            isWaiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : HorizontalList(itemList: popularMovies),
            // HorizontalList(isWaiting: isWaiting, itemList: popularMovies),
            // HorizontalList(isWaiting: isWaiting, itemList: popularMovies),
            // HorizontalList(isWaiting: isWaiting, itemList: popularMovies),
            // HorizontalList(isWaiting: isWaiting, itemList: popularMovies),
          ],
        ),
      ),
    );
  }
}
