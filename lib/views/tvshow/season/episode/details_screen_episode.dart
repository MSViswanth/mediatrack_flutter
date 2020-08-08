import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mediatrack_flutter/components/person/horizontal_list_cast.dart';
import 'package:mediatrack_flutter/components/person/horizontal_list_crew.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/tvshow/season/episode/episode.dart';

class DetailsScreenEpisode extends StatelessWidget {
  final Episode episode;
  final String seasonposterPath;
  DetailsScreenEpisode(this.episode, this.seasonposterPath);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: episode != null
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: seasonposterPath != null
                      ? CachedNetworkImageProvider(
                          baseUrl + posterSize + seasonposterPath)
                      : CachedNetworkImageProvider(url),
                  fit: BoxFit.cover,
                  colorFilter: seasonposterPath != null
                      ? ColorFilter.mode(
                          Colors.black,
                          BlendMode.screen,
                        )
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
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black.withOpacity(0.4)
                        : Colors.white.withOpacity(0.8),
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          pinned: true,
                          expandedHeight: 0.3 * size.height,
                          flexibleSpace: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: episode.stillPath != null
                                    ? CachedNetworkImageProvider(
                                        baseUrl +
                                            backdropSize +
                                            episode.stillPath,
                                      )
                                    : CachedNetworkImageProvider(url),
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
                                            episode.name,
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              episode.airDate != null
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                        right: 8,
                                                        top: 8,
                                                        bottom: 8,
                                                      ),
                                                      child: Text(
                                                        episode.airDate != ''
                                                            ? DateFormat.yMMMd()
                                                                .format(
                                                                DateTime.parse(
                                                                    episode
                                                                        .airDate),
                                                              )
                                                            : 'NA',
                                                        style: GoogleFonts.lato(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              episode.voteAverage != 0
                                                  ? Text(
                                                      ' ⭐ ${episode.voteAverage}',
                                                      style: GoogleFonts.lato(
                                                        fontSize: 16,
                                                      ),
                                                    )
                                                  : Text(
                                                      'NA',
                                                      style: GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                        color: Colors.grey,
                                                      )),
                                                    )
                                            ],
                                          ),
                                          Text(
                                            'S' +
                                                episode.seasonNumber
                                                    .toString() +
                                                'E' +
                                                episode.episodeNumber
                                                    .toString(),
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
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 500 / 750,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: seasonposterPath != null
                                              ? CachedNetworkImage(
                                                  imageUrl: baseUrl +
                                                      posterSize +
                                                      seasonposterPath,
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
                                  episode.overview == ''
                                      ? 'Not Available'
                                      : episode.overview,
                                  style: GoogleFonts.lato(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                              ),
                              episode.guestStars != null
                                  ? episode.guestStars.length != 0
                                      ? HorizontalListCast(
                                          itemList: episode.guestStars,
                                          title: 'Guest Stars',
                                        )
                                      : Container()
                                  : Container(),
                              episode.crew != null
                                  ? episode.crew.length != 0
                                      ? HorizontalListCrew(
                                          itemList: episode.crew,
                                          title: 'Crew',
                                        )
                                      : Container()
                                  : Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'Go into the episode view from season page for more details.',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
