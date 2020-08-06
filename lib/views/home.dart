import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediatrack_flutter/components/movie/horizontal_list_movie.dart';
import 'package:mediatrack_flutter/components/person/horizontal_list_person.dart';
import 'package:mediatrack_flutter/components/tvshow/horizontal_list_tvshow.dart';

import 'package:mediatrack_flutter/models/movie/movie.dart';
import 'package:mediatrack_flutter/models/person/person.dart';
import 'package:mediatrack_flutter/models/tvshow/tvshow.dart';
import 'package:mediatrack_flutter/providers/movie/movie_provider.dart';
import 'package:mediatrack_flutter/providers/person/person_provider.dart';
import 'package:mediatrack_flutter/providers/settings_provider.dart';
import 'package:mediatrack_flutter/providers/tvshow/tvshow_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MovieProvider moviesProvider = Provider.of<MovieProvider>(context);
    TVShowProvider tvProvider = Provider.of<TVShowProvider>(context);
    PersonProvider personProvider = Provider.of<PersonProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    bool isWaitingMovie = moviesProvider.isWaiting;
    bool isWaitingTv = tvProvider.isWaiting;
    bool isWaitingPerson = personProvider.isWaiting;
    List<Movie> trendingMovies = moviesProvider.trendingMovies;
    List<TVShow> trendingTVShows = tvProvider.trendingTVShows;
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
            isWaitingMovie
                ? Container(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : HorizontalListMovie(
                    itemList: trendingMovies,
                    title: 'Trending Movies',
                  ),
            isWaitingTv
                ? Container(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : HorizontalListTVShow(
                    itemList: trendingTVShows,
                    title: 'Trending TV Shows',
                  ),
            isWaitingPerson
                ? Container(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : HorizontalListPerson(
                    itemList: trendingPeople,
                    title: 'Trending People',
                  ),
          ],
        ),
      ),
    );
  }
}
