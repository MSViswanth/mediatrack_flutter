import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/configuration/countries.dart';
import 'package:mediatrack_flutter/models/configuration/languages.dart';
import 'package:http/http.dart' as http;

class ConfigurationProvider with ChangeNotifier {
  List<Country> _countries = [];
  List<Language> _languages = [];

  ConfigurationProvider() {
    getCountries();
    getLanguages();
  }

  void getCountries() async {
    try {
      http.Response response = await http.get(
          'https://api.themoviedb.org/3/configuration/countries?api_key=' +
              kAPIKey);
      _countries = (json.decode(response.body) as List)
          .map((i) => Country.fromJson(i))
          .toList();
    } catch (e) {
      print(e);
    }
  }

  void getLanguages() async {
    try {
      http.Response response = await http.get(
          'https://api.themoviedb.org/3/configuration/languages?api_key=' +
              kAPIKey);
      _languages = (json.decode(response.body) as List)
          .map((e) => Language.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
    }
  }

  get countries => _countries;
  get languages => _languages;
}
