import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/models/movie.dart';

import 'package:mediatrack_flutter/services/tmdb_service.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MoviesProvider with ChangeNotifier {
  List<Movie> _trendingMovies = [];
  bool _isWaiting = true;
  String _certification = 'NR';

  ///Constructor for MoviesProvider class.
  MoviesProvider() {
    getTrendingMovies();
  }

  ///Get Certification.
  getCertification(Movie movie) async {
    // Future.delayed(Duration(milliseconds: 1000));

    for (var item in movie.releaseDates.results) {
      if (item.iso_3166_1 == 'US') {
        _certification = item.releaseDates[0].certification;
      }
    }

    // print(_certification);
  }

  get certification => _certification;

  ///Update the details with complete information.
  ///
  ///
  ///`Pass [movie] and the [index]`
  ///
  void updateDetails(List<Movie> movie, int index) async {
    try {
      Map movieUpdated = await tmdb.v3.movies.getDetails(movie[index].id,
          appendToResponse: 'release_dates,similar_movies');
      movie[index] = Movie.fromJson(movieUpdated);

      await getCertification(movie[index]);
    } catch (e) {
      print(e);
    }

    notifyListeners();
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

  resetDetails() {
    _certification = 'Waiting';
  }
}
