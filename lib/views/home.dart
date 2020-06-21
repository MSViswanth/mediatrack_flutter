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
                return Container(
                  padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(),
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
