import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediatrack_flutter/components/horizontal_list.dart';
import 'package:mediatrack_flutter/components/horizontal_list_person.dart';
import 'package:mediatrack_flutter/components/horizontal_list_tv.dart';

import 'package:mediatrack_flutter/models/movie.dart';
import 'package:mediatrack_flutter/models/person.dart';
import 'package:mediatrack_flutter/models/show.dart';
import 'package:mediatrack_flutter/providers/movies_provider.dart';
import 'package:mediatrack_flutter/providers/person_provider.dart';
import 'package:mediatrack_flutter/providers/settings_provider.dart';
import 'package:mediatrack_flutter/providers/tv_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MoviesProvider moviesProvider = Provider.of<MoviesProvider>(context);
    TVProvider tvProvider = Provider.of<TVProvider>(context);
    PersonProvider personProvider = Provider.of<PersonProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    bool isWaiting = moviesProvider.isWaiting;
    bool isWaitingTv = tvProvider.isWaiting;
    bool isWaitingPerson = personProvider.isWaiting;
    List<Movie> trendingMovies = moviesProvider.trendingMovies;
    List<Show> trendingTVShows = tvProvider.trendingTVShows;
    List<Person> trendingPeople = personProvider.trendingPeople;

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
                  textStyle: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Trending Movies',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
            isWaiting
                ? Container(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : HorizontalList(itemList: trendingMovies),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Trending TV Shows',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
            isWaitingTv
                ? Container(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : HorizontalListTV(itemList: trendingTVShows),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Trending People',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
            isWaitingTv
                ? Container(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : HorizontalListPerson(itemList: trendingPeople),
            // HorizontalList(isWaiting: isWaiting, itemList: popularMovies),
            // HorizontalList(isWaiting: isWaiting, itemList: popularMovies),
            // HorizontalList(isWaiting: isWaiting, itemList: popularMovies),
          ],
        ),
      ),
    );
  }
}
