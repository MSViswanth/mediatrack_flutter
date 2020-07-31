import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/models/movie/collection/collection.dart';
import 'package:mediatrack_flutter/services/tmdb_service.dart';

class CollectionProvider with ChangeNotifier {
  Collection _collection;

  void getDetails(int collectionId) async {
    try {
      Map collectionNew = await tmdb.v3.collections.getDetails(collectionId);
      _collection = Collection.fromJson(collectionNew);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  resetDetails() {
    _collection = null;
  }

  get collection => _collection;
}
