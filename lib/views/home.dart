import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

    return SafeArea(
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
          HorizontalList(isWaiting: isWaiting, popularMovies: popularMovies),
          HorizontalList(isWaiting: isWaiting, popularMovies: popularMovies),
          HorizontalList(isWaiting: isWaiting, popularMovies: popularMovies),
          HorizontalList(isWaiting: isWaiting, popularMovies: popularMovies),
          HorizontalList(isWaiting: isWaiting, popularMovies: popularMovies),
        ],
      ),
    );
  }
}

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    Key key,
    @required this.isWaiting,
    @required this.popularMovies,
  }) : super(key: key);

  final bool isWaiting;
  final List<Movie> popularMovies;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).scaffoldBackgroundColor,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(5),
      height: 200,
      child: isWaiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // String name = popularMovies[index].title;
                Provider.of<MoviesProvider>(context)
                    .updateDetails(popularMovies[index], index);
                return Container(
                  padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    onLongPress: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              color: Provider.of<SettingsProvider>(context)
                                          .themeData
                                          .brightness ==
                                      Brightness.dark
                                  ? Color(0xff161616)
                                  : Color(
                                      0xff6d6d6d), //Behind bottomsheet color. (Rounded Corners).
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  //Add ClipRRect
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor, //BottomSheet background color.
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                child: Container(
                                  // height: 200,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 200,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              // height: 200,

                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.network(
                                                  baseUrl +
                                                      posterSize +
                                                      popularMovies[index]
                                                          .posterPath,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(12.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      popularMovies[index]
                                                          .title,
                                                      style: TextStyle(
                                                          fontSize: 24),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      '${popularMovies[index].voteAverage}',
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            popularMovies[index].tagline,
                                          ),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: 20,
                                      // ),
                                      Expanded(
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: popularMovies[index]
                                                .genres
                                                .length,
                                            itemBuilder: (context, genre) {
                                              return Padding(
                                                padding: EdgeInsets.all(5.0),
                                                child: Chip(
                                                  label: Text(
                                                      '${popularMovies[index].genres[genre].name} '),
                                                ),
                                              );
                                            }),
                                      ),
                                      Expanded(
                                        child: Center(
                                            child: Text(
                                                popularMovies[index].status)),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                              popularMovies[index].releaseDate),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(5, 5),
                            blurRadius: 3,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        //Removed Aspect Ratio. Add if necessary.
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(baseUrl +
                            posterSize +
                            popularMovies[index].posterPath),
                      ),
                    ),
                  ),
                );
              },
              itemCount: popularMovies.length,
            ),
    );
  }
}
