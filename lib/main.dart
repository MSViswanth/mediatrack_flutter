import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediatrack_flutter/providers/movie/collection/collection_provider.dart';
import 'package:mediatrack_flutter/providers/movie/movie_provider.dart';
import 'package:mediatrack_flutter/providers/person/person_provider.dart';
import 'package:mediatrack_flutter/providers/settings_provider.dart';
import 'package:mediatrack_flutter/providers/tvshow/tvshow_provider.dart';
import 'package:mediatrack_flutter/views/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TVShowProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PersonProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CollectionProvider(),
        )
      ],
      child: Consumer5<SettingsProvider, MovieProvider, TVShowProvider,
          PersonProvider, CollectionProvider>(
        builder: (context, settingsProvider, moviesProvider, tvProvider,
                personProvider, collectionProvider, child) =>
            MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MediaTrack',
          theme: settingsProvider.themeData,
          home: HomePage(),
        ),
      ),
    );
  }
}
