import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/models/show.dart';
import 'package:mediatrack_flutter/services/tmdb_service.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TVProvider with ChangeNotifier {
  List<Show> _trendingTVShows = [];
  bool _isWaiting = true;

  TVProvider() {
    getTrendingTVShows();
  }

  void updateDetails(List<Show> show, int index) async {
    try {
      Map tvUpdated = await tmdb.v3.tv.getDetails(
        show[index].id,
      );
      show[index] = Show.fromJson(tvUpdated);
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
        _trendingTVShows.add(Show.fromJson(trendingShow));
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
