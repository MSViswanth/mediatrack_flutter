import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/models/movie/collection/collection.dart';
import 'package:mediatrack_flutter/services/tmdb_service.dart';

class CollectionProvider with ChangeNotifier {
  Future<Collection> getDetails(Collection collection) async {
    try {
      Map collectionNew = await tmdb.v3.collections.getDetails(collection.id);
      collection = Collection.fromJson(collectionNew);
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return collection;
  }
}
