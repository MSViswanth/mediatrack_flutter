import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/models/tvshow/tvshow.dart';
import 'package:mediatrack_flutter/services/tmdb_service.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TVShowProvider with ChangeNotifier {
  List<TVShow> _trendingTVShows = [];
  bool _isWaiting = true;

  TVShowProvider() {
    getTrendingTVShows();
  }

  void updateDetails(List<TVShow> show, int index) async {
    try {
      Map tvUpdated = await tmdb.v3.tv.getDetails(
        show[index].id,appendToResponse: 'similar,recommendations'
      );
      show[index] = TVShow.fromJson(tvUpdated);
      // print(movie[index].homepage);

    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  void getTrendingTVShows() async {
    try {
      Map trendingTVShowsList = await tmdb.v3.trending
          .getTrending(mediaType: MediaType.tv, timeWindow: TimeWindow.day);
      for (Map trendingShow in trendingTVShowsList['results']) {
        _trendingTVShows.add(TVShow.fromJson(trendingShow));
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

  get trendingTVShows => _trendingTVShows;
}
