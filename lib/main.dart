import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/providers/settings_provider.dart';
import 'package:mediatrack_flutter/views/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // builder: (_) => SettingsProvider(),
      create: (context) => SettingsProvider(),
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MediaTrack',
          theme: settingsProvider.themeData,
          home: HomePage(title: 'MediaTrack'),
        ),
      ),
    );
  }
}
