import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/models/tvshow/season/season.dart';
import 'package:mediatrack_flutter/services/tmdb_service.dart';
import 'package:tmdb_api/tmdb_api.dart';

class SeasonProvider with ChangeNotifier {
  Season _season;
  bool _isWaiting = true;

  void getSeasonDetails(int tvId, int seasonNumber) async {
    try {
      Map seasonDetails =
          await tmdb.v3.tvSeasons.getDetails(tvId, seasonNumber);
      _season = Season.fromJson(seasonDetails);
      _isWaiting = false;
      // print(movie[index].homepage);
      //print(_season.episodes);
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

//  void getTrendingTVShows() async {
//    try {
//      Map trendingTVShowsList = await tmdb.v3.trending
//          .getTrending(mediaType: MediaType.tv, timeWindow: TimeWindow.day);
//      for (Map trendingShow in trendingTVShowsList['results']) {
//        _trendingTVShows.add(TVShow.fromJson(trendingShow));
//      }
//
//      // print(_trendingMovies.length);
//    } catch (e) {
//      print(e);
//    }
//    _isWaiting = false;
//    notifyListeners();
//  }

  ///Get the boolean of isWaiting Property.
  get isWaiting => _isWaiting;

  get season => _season;
}
