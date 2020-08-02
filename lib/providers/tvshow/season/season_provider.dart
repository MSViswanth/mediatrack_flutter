import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/models/tvshow/season/season.dart';
import 'package:mediatrack_flutter/services/tmdb_service.dart';

class SeasonProvider with ChangeNotifier {
  Future<Season> getDetails(int tvId, Season season) async {
    try {
      Map seasonNew = await tmdb.v3.tvSeasons
          .getDetails(tvId, season.seasonNumber, appendToResponse: 'credits');
      season = Season.fromJson(seasonNew);
    } catch (e) {
      print(e);
    }

    notifyListeners();
    return season;
  }
}
