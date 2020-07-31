import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/models/movie/collection/collection.dart';
import 'package:mediatrack_flutter/services/tmdb_service.dart';

class CollectionProvider with ChangeNotifier {
  Collection _collection;
  bool _isWaiting = true;
  CollectionProvider(){
    resetDetails();
  }

  void getDetails(int collectionId) async {
    try {
      Map collectionNew = await tmdb.v3.collections.getDetails(collectionId);
      _collection = Collection.fromJson(collectionNew);
      _isWaiting = false;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  resetDetails() {
    _isWaiting=true;
  }

  get collection => _collection;
  get isWaiting => _isWaiting;
}
