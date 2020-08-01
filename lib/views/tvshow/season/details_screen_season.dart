import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mediatrack_flutter/components/person/horizontal_list_cast.dart';
import 'package:mediatrack_flutter/components/person/horizontal_list_crew.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/tvshow/season/season.dart';
import 'package:mediatrack_flutter/providers/tvshow/season/season_provider.dart';
import 'package:mediatrack_flutter/views/home_page.dart';
import 'package:mediatrack_flutter/views/tvshow/details_screen_tv.dart';
import 'package:provider/provider.dart';

class DetailsScreenSeason extends StatefulWidget {
  final int tvId;
  final int seasonNumber;
  final String backdropPath;
  final String tvshowName;
  DetailsScreenSeason({
    @required this.tvId,
    @required this.seasonNumber,
    @required this.backdropPath,
    @required this.tvshowName,
  });
  @override
  _DetailsScreenSeasonState createState() => _DetailsScreenSeasonState();
}

class _DetailsScreenSeasonState extends State<DetailsScreenSeason> {
  @override
  void initState() {
    super.initState();
    seasonProvider.resetDetails();
    seasonProvider.getDetails(widget.tvId, widget.seasonNumber);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Season season = seasonProvider.season;
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
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverAppBar(
                            floating: true,
                            title: Text(widget.tvshowName),
                            expandedHeight: 0.3 * size.height,
                            flexibleSpace: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: widget.backdropPath != null
                                      ? CachedNetworkImageProvider(baseUrl +
                                          backdropSize +
                                          widget.backdropPath)
                                      : NetworkImage(url),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate(
                              <Widget>[
                                Container(
                                  padding: EdgeInsets.all(16),
                                  height: 200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 0.6 * size.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                            season.airDate != null
                                                ? Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    child: Text(
                                                      season.airDate != ''
                                                          ? DateFormat.yMMMd()
                                                              .format(
                                                              DateTime.parse(
                                                                  season
                                                                      .airDate),
                                                            )
                                                          : 'NA',
                                                      style: GoogleFonts.lato(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                            Text(
                                              season.episodes.length
                                                      .toString() +
                                                  ' episodes',
                                              style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            )
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: AspectRatio(
                                          aspectRatio: 500 / 750,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: season.posterPath != null
                                                ? CachedNetworkImage(
                                                    imageUrl: baseUrl +
                                                        posterSize +
                                                        season.posterPath,
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                progress) =>
                                                            Container(
                                                      color: Colors.white,
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value:
                                                              progress.progress,
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
                                                        textAlign:
                                                            TextAlign.center,
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
                                  padding: EdgeInsets.all(16),
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
                                      horizontal: 16, vertical: 0),
                                  child: Text(
                                    season.overview == ''
                                        ? 'Not Available'
                                        : season.overview,
                                    style: GoogleFonts.lato(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                ),
                                season.episodes.length != 0
                                    ? Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Text(
                                          'Episodes',
                                          style: GoogleFonts.lato(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.all(8),
                                      ),
                              ],
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  height: 100,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(5, 5),
                                                  blurRadius: 3,
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: season.episodes[index]
                                                          .stillPath !=
                                                      null
                                                  ? CachedNetworkImage(
                                                      imageUrl: baseUrl +
                                                          stillSize +
                                                          season.episodes[index]
                                                              .stillPath,
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  progress) =>
                                                              Container(
                                                        color: Theme.of(context)
                                                            .scaffoldBackgroundColor,
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            value: progress
                                                                .progress,
                                                          ),
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Center(
                                                      child: Text(
                                                          'Image Not Available'),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                season.episodes[index].name,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              season.episodes[index]
                                                          .voteAverage !=
                                                      0
                                                  ? Text(
                                                      '⭐ ' +
                                                          season.episodes[index]
                                                              .voteAverage
                                                              .toString(),
                                                      style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    )
                                                  : Text('NA'),
                                              Text(
                                                'S' +
                                                    season.episodes[index]
                                                        .seasonNumber
                                                        .toString() +
                                                    'E' +
                                                    season.episodes[index]
                                                        .episodeNumber
                                                        .toString(),
                                                style: GoogleFonts.lato(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              childCount: season.episodes.length,
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate(
                              <Widget>[
                                season.credits != null
                                    ? season.credits.cast.length != 0
                                        ? HorizontalListCast(
                                            itemList: season.credits.cast,
                                            title: 'Cast',
                                          )
                                        : Container(
                                            padding: EdgeInsets.all(16),
                                            child: Center(
                                              child: Text(
                                                'Cast Not Available',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          )
                                    : Container(
                                        height: 200,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                season.credits != null
                                    ? season.credits.crew.length != 0
                                        ? HorizontalListCrew(
                                            itemList: season.credits.crew,
                                            title: 'Crew',
                                          )
                                        : Container(
                                            padding: EdgeInsets.all(16),
                                            child: Center(
                                              child: Text(
                                                'Crew Not Available',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          )
                                    : Container(
                                        height: 200,
                                        child: Center(
                                          child: CircularProgressIndicator(),
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
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
