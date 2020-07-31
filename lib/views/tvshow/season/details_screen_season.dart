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
  final int tvId;
  final int seasonNumber;
  DetailsScreenSeason({
    @required this.tvId,
    @required this.seasonNumber,
  });
  @override
  _DetailsScreenSeasonState createState() => _DetailsScreenSeasonState();
}

class _DetailsScreenSeasonState extends State<DetailsScreenSeason> {
  @override
  void initState() {
    super.initState();
    seasonProvider.getDetails(widget.tvId, widget.seasonNumber);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Season season = seasonProvider.season;
    // print(season.name);
    return Scaffold(
        body: season != null
            ? Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: season.posterPath != null
                        ? CachedNetworkImageProvider(
                            baseUrl + posterSize + season.posterPath,
                          )
                        : NetworkImage(url),
                    fit: BoxFit.cover,
                    colorFilter: season.posterPath != null
                        ? ColorFilter.mode(Colors.black, BlendMode.screen)
                        : ColorFilter.mode(
                            Colors.white,
                            BlendMode.clear,
                          ),
                  ),
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(16),
                            height: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 0.6 * size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        season.name,
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          '${season.episodes.length} episodes',
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(5, 5),
                                        blurRadius: 3,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 500 / 750,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: season.posterPath != null
                                          ? CachedNetworkImage(
                                              imageUrl: baseUrl +
                                                  posterSize +
                                                  season.posterPath,
                                              progressIndicatorBuilder:
                                                  (context, url, progress) =>
                                                      Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: progress.progress,
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              fit: BoxFit.cover,
                                            )
                                          : Container(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              padding: EdgeInsets.all(3),
                                              child: Center(
                                                  child: Material(
                                                child: Text(
                                                  'Image not available',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              )),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                              bottom: 0,
                            ),
                            child: Text(
                              'Overview',
                              style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.headline6,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: season.overview != ''
                                ? Text(
                                    season.overview,
                                    style: GoogleFonts.lato(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  )
                                : Text(
                                    'Not Available',
                                    style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        color: Colors.grey),
                                  ),
                          ),
                          InkWell(
                            onTap: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                              (Route<dynamic> route) => false,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.home,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  Spacer(),
                                  Text(
                                    'Go Home',
                                    style: GoogleFonts.lato(
                                      textStyle:
                                          Theme.of(context).textTheme.headline6,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
