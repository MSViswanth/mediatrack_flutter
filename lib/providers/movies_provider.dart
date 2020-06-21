import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/models/movie.dart';
import 'package:mediatrack_flutter/services/tmdb_service.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MoviesProvider with ChangeNotifier {
  List<Movie> _trendingMovies = [];
  bool _isWaiting = true;

  ///Constructor for MoviesProvider class.
  MoviesProvider() {
    getTrendingMovies();
  }

  updateDetails(Movie movie, int index) async {
    Map movieUpdated = await tmdb.v3.movies.getDetails(movie.id);
    _trendingMovies[index] = Movie.fromJson(movieUpdated);
  }

  ///Get Trending Movies.
  void getTrendingMovies() async {
    try {
      Map trendingMoviesList = await tmdb.v3.trending
          .getTrending(mediaType: MediaType.movie, timeWindow: TimeWindow.day);
      for (Map trendingMovie in trendingMoviesList['results']) {
        _trendingMovies.add(Movie.fromJson(trendingMovie));
      }

      // print(_trendingMovies.length);
    } catch (e) {
      print(e);
    }
    _isWaiting = false;
    notifyListeners();
  }

  ///Get the boolean of isWaiting Property.
  get isWaiting => _isWaiting;

  ///Get a list of Trending Movies.
  get trendingMovies => _trendingMovies;
}
