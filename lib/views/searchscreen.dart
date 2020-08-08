import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/components/movie/horizontal_list_movie.dart';
import 'package:mediatrack_flutter/components/tvshow/horizontal_list_tvshow.dart';
import 'package:mediatrack_flutter/models/movie/movie.dart';
import 'package:mediatrack_flutter/models/tvshow/tvshow.dart';
import 'package:mediatrack_flutter/services/tmdb_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Movie> searchMovie = [];
  List<TVShow> searchTVShow = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Enter the name of movie, show etc..',
                  ),
                  onSubmitted: (value) async {
                    searchMovie.clear();
                    Map search2 = await tmdb.v3.search.queryMovies(value);
                    for (Map searchmovie in search2['results']) {
                      setState(() {
                        searchMovie.add(Movie.fromJson(searchmovie));
                      });
                    }
                    print(searchMovie.length);
                    searchTVShow.clear();
                    Map search3 = await tmdb.v3.search.queryTvShows(value);
                    for (Map searchtvshow in search3['results']) {
                      setState(() {
                        searchTVShow.add(TVShow.fromJson(searchtvshow));
                      });
                    }
                    print(searchTVShow.length);
                  }),
            ),
            HorizontalListMovie(
              itemList: searchMovie,
              title: 'Movies',
            ),
            HorizontalListTVShow(
              itemList: searchTVShow,
              title: 'TV Shows',
            ),
          ],
        ),
      ),
    );
  }
}
