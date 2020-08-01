import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/models/configuration/countries.dart';
import 'package:mediatrack_flutter/models/configuration/languages.dart';
import 'package:mediatrack_flutter/models/tvshow/tvshow.dart';

import 'package:mediatrack_flutter/providers/settings_provider.dart';
import 'package:mediatrack_flutter/services/tmdb_service.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TVShowProvider with ChangeNotifier {
  List<TVShow> _trendingTVShows = [];
  bool _isWaiting = true;
  String _certification = 'NR';
  String _originalLanguage;
  String _spokenLanguage;
  String _originCountry;
  TVShowProvider() {
    getTrendingTVShows();
  }

  //Get Certification.
  getCertification(TVShow show) async {
    // Future.delayed(Duration(milliseconds: 1000));

    for (var item in show.contentRatings.results) {
      if (item.iso_3166_1 == 'US') {
        _certification = item.rating;
      }
    }
  }

  get certification => _certification;

  void updateDetails(List<TVShow> show, int index) async {
    try {
      Map tvUpdated = await tmdb.v3.tv.getDetails(show[index].id,
          appendToResponse:
              'similar,recommendations,content_ratings,external_ids,credits');
      show[index] = TVShow.fromJson(tvUpdated);

      await getCertification(show[index]);
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

  String getLanguage(TVShow tvShow) {
    for (Language item in configurationProvider.languages) {
      if (tvShow.originalLanguage == item.iso_639_1) {
        if (item.name != '') {
          _originalLanguage = item.name;
        } else {
          _originalLanguage = item.englishName;
        }
      }
    }
    return _originalLanguage;
  }

  String getSpokenLanguages(String lang) {
    for (Language item in configurationProvider.languages) {
      if (lang == item.iso_639_1) {
        if (item.name != '') {
          _spokenLanguage = item.name;
        } else {
          _spokenLanguage = item.englishName;
        }
      }
    }
    return _spokenLanguage;
  }

  String getOriginCoutries(String country) {
    for (Country item in configurationProvider.countries) {
      if (country == item.iso_3166_1) {
        _originCountry = item.englishName;
      }
    }
    return _originCountry;
  }

  resetDetails() {
    _certification = 'NR';
  }

  ///Get the boolean of isWaiting Property.
  get isWaiting => _isWaiting;

  get trendingTVShows => _trendingTVShows;
}
