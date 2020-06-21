import 'package:tmdb_api/tmdb_api.dart';

import '../constants.dart';

ApiKeys keys = ApiKeys(kAPIKey, kAPIReadAccessToken);

TMDB tmdb = TMDB(keys, logConfig: ConfigLogger.showAll());
