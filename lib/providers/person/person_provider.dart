import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/models/person/person.dart';
import 'package:mediatrack_flutter/services/tmdb_service.dart';
import 'package:tmdb_api/tmdb_api.dart';

class PersonProvider with ChangeNotifier {
  List<Person> _trendingPeople = [];
  bool _isWaiting = true;
  Person _person;

  PersonProvider() {
    getTrendingPeople();
  }

  void updateDetails(List<Person> person, int index) async {
    try {
      Map personUpdated = await tmdb.v3.people.getDetails(
        person[index].id,
      );
      person[index] = Person.fromJson(personUpdated);
      // print(movie[index].homepage);

    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  void getPerson(int id) async {
    try {
      Map personUpdated = await tmdb.v3.people.getDetails(
        id,
      );
      _person = Person.fromJson(personUpdated);
      // print(movie[index].homepage);

    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  void getTrendingPeople() async {
    try {
      Map trendingPeopleList = await tmdb.v3.trending
          .getTrending(mediaType: MediaType.person, timeWindow: TimeWindow.day);
      for (Map trendingPerson in trendingPeopleList['results']) {
        _trendingPeople.add(Person.fromJson(trendingPerson));
      }

      // print(_trendingMovies.length);
    } catch (e) {
      print(e);
    }
    _isWaiting = false;
    notifyListeners();
  }

  resetDetails() {
    _person = null;
  }

  ///Get the boolean of isWaiting Property.
  get isWaiting => _isWaiting;

  get trendingPeople => _trendingPeople;

  get person => _person;
}
