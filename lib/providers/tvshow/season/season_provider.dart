import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/models/tvshow/season/season.dart';
import 'package:mediatrack_flutter/services/tmdb_service.dart';

class SeasonProvider with ChangeNotifier {
  Season _season;

  void getDetails(int tvId, int seasonNumber) async {
    try {
      Map seasonNew = await tmdb.v3.tvSeasons
          .getDetails(tvId, seasonNumber, appendToResponse: 'credits');
      _season = Season.fromJson(seasonNew);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  resetDetails() {
    _season = null;
  }

  get season => _season;
}
