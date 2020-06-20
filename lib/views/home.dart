import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_api/tmdb_api.dart';

ApiKeys keys = ApiKeys(kAPIKey, kAPIReadAccessToken);

TMDB tmdb = TMDB(keys, logConfig: ConfigLogger.showAll());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map popularMovies;
  bool isWaiting = true;

  void getPopularMovies() async {
    try {
      popularMovies = await tmdb.v3.trending
          .getTrending(mediaType: MediaType.movie, timeWindow: TimeWindow.day);
    } catch (e) {
      print(e);
    }
    try {
      setState(() {
        isWaiting = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
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
          // Text('Trending'),
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
  final Map popularMovies;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                String name = popularMovies['results'][index]['name'];
                return Container(
                  padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Text(name);
                          });
                    },
                    child: AspectRatio(
                      aspectRatio: 2.0 / 3.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(baseUrl +
                            posterSize +
                            popularMovies['results'][index]['poster_path']),
                      ),
                    ),
                  ),
                );
              },
              itemCount: popularMovies['results'].length,
            ),
    );
  }
}
