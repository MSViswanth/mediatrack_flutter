import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/tvshow/season/season.dart';
import 'package:mediatrack_flutter/providers/tvshow/season/season_provider.dart';
import 'package:mediatrack_flutter/views/home_page.dart';
import 'package:mediatrack_flutter/views/tvshow/details_screen_tv.dart';
import 'package:provider/provider.dart';

class DetailsScreenSeason extends StatefulWidget {
  @override
  _DetailsScreenSeasonState createState() => _DetailsScreenSeasonState();
}

class _DetailsScreenSeasonState extends State<DetailsScreenSeason> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Season season = Provider.of<SeasonProvider>(context).season;
    return Container(
      color: Colors.white,
      child: Text(season.airDate),
    );
  }
}
