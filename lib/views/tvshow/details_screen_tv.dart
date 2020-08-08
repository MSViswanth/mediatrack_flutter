import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediatrack_flutter/components/person/horizontal_list_cast.dart';
import 'package:mediatrack_flutter/components/person/horizontal_list_crew.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/tvshow/tvshow.dart';
import 'package:mediatrack_flutter/providers/tvshow/season/season_provider.dart';
import 'package:mediatrack_flutter/providers/tvshow/tvshow_provider.dart';
import 'package:mediatrack_flutter/views/tvshow/season/details_screen_season.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mediatrack_flutter/views/home_page.dart';
import 'package:mediatrack_flutter/components/tvshow/season/horizontal_list_season.dart';
import 'package:mediatrack_flutter/components/tvshow/horizontal_list_tvshow.dart';

SeasonProvider
    seasonProvider; //Here it's not initialized because we only need it after we are on current screen. It's not used on first screen.

class DetailsScreenTVShow extends StatefulWidget {
  final TVShow tvshow;

  DetailsScreenTVShow({
    this.tvshow,
  });

  @override
  _DetailsScreenTVShowState createState() => _DetailsScreenTVShowState();
}

class _DetailsScreenTVShowState extends State<DetailsScreenTVShow> {
  TVShowProvider resetTVDetailsProvider;

  @override
  void dispose() {
    resetTVDetailsProvider.resetDetails();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    seasonProvider = Provider.of<SeasonProvider>(context);
    resetTVDetailsProvider = Provider.of<TVShowProvider>(context);
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: widget.tvshow.posterPath != null
                ? CachedNetworkImageProvider(
                    baseUrl + posterSize + widget.tvshow.posterPath,
                  )
                : CachedNetworkImageProvider(url),
            fit: BoxFit.cover,
            colorFilter: widget.tvshow.posterPath != null
                ? ColorFilter.mode(Colors.black, BlendMode.screen)
                : ColorFilter.mode(Colors.white, BlendMode.clear)),
      ),
      child: ClipRect(
          child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black.withOpacity(0.4)
              : Colors.white.withOpacity(0.8),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text(
                  widget.tvshow.name,
                  style: TextStyle(color: Colors.white),
                ),
                pinned: true,
                expandedHeight: 0.3 * size.height,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: widget.tvshow.backdropPath == null
                          ? NetworkImage(url) //TODO: Add placeholder.
                          : CachedNetworkImageProvider(
                              baseUrl +
                                  backdropSize +
                                  widget.tvshow.backdropPath,
                            ),
                      fit: BoxFit.cover,
                    ),
                    gradient: LinearGradient(
                      colors: [Colors.teal, Colors.blue],
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0, 0.5, 1],
                        colors: [
                          Colors.transparent,
                          Colors.black26,
                          Colors.black87,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 0.6 * size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            //TODO
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              widget.tvshow.originalName != null &&
                                      widget.tvshow.originalLanguage != null
                                  ? Text(
                                      widget.tvshow.originalName,
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  : Text(
                                      widget.tvshow.name,
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Provider.of<TVShowProvider>(context)
                                            .getLanguage(widget.tvshow) !=
                                        null
                                    ? Text(Provider.of<TVShowProvider>(context)
                                        .getLanguage(widget.tvshow))
                                    : Text(widget.tvshow.originalLanguage),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    widget.tvshow.firstAirDate != ''
                                        ? Text(
                                            '${DateTime.parse(widget.tvshow.firstAirDate).year}' +
                                                ' - ' +
                                                '${widget.tvshow.status == 'Ended' || widget.tvshow.status == 'Canceled' ? DateTime.parse(widget.tvshow.lastEpisodeToAir.airDate).year : 'Present'}',
                                            style: TextStyle(fontSize: 16),
                                          )
                                        : Text('Not Available'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    widget.tvshow.voteAverage != 0
                                        ? Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.star,
                                                color: Color(0xff90cea1),
                                                size: 28,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                widget.tvshow.voteAverage
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Text(
                                            'NR',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                  ],
                                ),
                              ),
                              Container(
                                child: widget.tvshow.seasons != null
                                    ? Text(
                                        '${widget.tvshow.numberOfEpisodes} Episodes',
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                      )
                                    : null,
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
                              child: widget.tvshow.posterPath != null
                                  ? CachedNetworkImage(
                                      imageUrl: baseUrl +
                                          posterSize +
                                          widget.tvshow.posterPath,
                                      progressIndicatorBuilder:
                                          (context, url, progress) => Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value: progress.progress,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
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
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      )),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 80,
                          child: widget.tvshow.status != null
                              ? Text(
                                  widget.tvshow.status,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 2,
                                )
                              : Container(
                                  width: 50,
                                  child: LinearProgressIndicator(),
                                ),
                        ),
                        widget.tvshow.episodeRunTime == null
                            ? Container(
                                width: 50,
                                child: LinearProgressIndicator(),
                              )
                            : widget.tvshow.episodeRunTime.length != 0
                                ? widget.tvshow.episodeRunTime[0] != 0
                                    ? Text(
                                        widget.tvshow.episodeRunTime[0] ~/ 60 !=
                                                    0 &&
                                                widget.tvshow
                                                            .episodeRunTime[0] %
                                                        60 !=
                                                    0
                                            ? '${widget.tvshow.episodeRunTime[0] ~/ 60}hr ${widget.tvshow.episodeRunTime[0] % 60}min'
                                            : widget.tvshow.episodeRunTime[0] ~/
                                                        60 ==
                                                    0
                                                ? '${widget.tvshow.episodeRunTime[0] % 60}min'
                                                : '${widget.tvshow.episodeRunTime[0] ~/ 60}hr',
                                        style: TextStyle(fontSize: 18),
                                      )
                                    : Text('NA')
                                : Text('NA'),
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    Theme.of(context).textTheme.bodyText2.color,
                              ),
                              borderRadius: BorderRadius.circular(3)),
                          child: Text(Provider.of<TVShowProvider>(context)
                                          .certification ==
                                      '' ||
                                  Provider.of<TVShowProvider>(context)
                                          .certification ==
                                      null
                              ? 'NR'
                              : Provider.of<TVShowProvider>(context)
                                  .certification),
                        ),
                        GestureDetector(
                          onTap: widget.tvshow.externalIds != null
                              ? () {
                                  launch(
                                    'http://www.imdb.com/title/' +
                                        widget.tvshow.externalIds.imdbId,
                                  );
                                }
                              : () {},
                          child: Image.asset(
                            'assets/images/imdb.png',
                            scale: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget.tvshow.homepage != null && widget.tvshow.homepage != ''
                      ? Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(16),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).accentColor,
                          ),
                          child: InkWell(
                            onTap: () => launch(widget.tvshow.homepage),
                            child: Center(
                              child: Text(
                                '\'' + widget.tvshow.name + '\'' + ' Website',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Overview',
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.headline6,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    child: Text(
                      widget.tvshow.overview,
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                  widget.tvshow.nextEpisodeToAir != null
                      ? Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Upcoming',
                            style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline6,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        )
                      : Container(),
                  widget.tvshow.nextEpisodeToAir != null
                      ? EpisodeListItem(
                          episode: widget.tvshow.nextEpisodeToAir,
                          posterPath: widget.tvshow.posterPath)
                      : Container(),
                  widget.tvshow.lastEpisodeToAir != null
                      ? Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Last Aired',
                            style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline6,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        )
                      : Container(),
                  widget.tvshow.lastEpisodeToAir != null
                      ? EpisodeListItem(
                          episode: widget.tvshow.lastEpisodeToAir,
                          posterPath: widget.tvshow.posterPath)
                      : Container(),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Genres',
                          style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline6,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).accentColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    margin: EdgeInsets.all(14),
                    height: 45,
                    child: widget.tvshow.genres != null
                        ? widget.tvshow.genres.length == 0
                            ? Center(
                                child: Text(
                                  'Not Available',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.tvshow.genres.length,
                                itemBuilder: (context, genre) {
                                  return Container(
                                    // height: 25,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .color,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      '${widget.tvshow.genres[genre].name}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  );
                                })
                        : Text('Waiting...'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  widget.tvshow.seasons != null
                      ? widget.tvshow.seasons.length != 0
                          ? HorizontalListSeasons(
                              itemList: widget.tvshow.seasons,
                              tvId: widget.tvshow.id,
                              backdropPath: widget.tvshow.backdropPath,
                              tvshowName: widget.tvshow.name,
                            )
                          : Container(
                              child: Center(
                                child: Text(
                                  'Seasons Not Available',
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
                  widget.tvshow.credits != null
                      ? widget.tvshow.credits.cast.length != 0
                          ? HorizontalListCast(
                              itemList: widget.tvshow.credits.cast,
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
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Spoken Languages',
                          style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline6,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).accentColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 25,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: widget.tvshow.languages == null
                        ? Text('Waiting...')
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.only(right: 16),
                                  child: Provider.of<TVShowProvider>(context)
                                              .getSpokenLanguages(widget
                                                  .tvshow.languages[index]) !=
                                          null
                                      ? Text(Provider.of<TVShowProvider>(
                                              context)
                                          .getSpokenLanguages(
                                              widget.tvshow.languages[index]))
                                      : Text(widget.tvshow.languages[index]));
                            },
                            itemCount: widget.tvshow.languages.length,
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Origin Countries',
                          style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline6,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).accentColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 25,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: widget.tvshow.originCountry == null
                        ? Text('Waiting...')
                        : widget.tvshow.originCountry.length != 0
                            ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: EdgeInsets.only(right: 16),
                                      child: Provider.of<TVShowProvider>(context)
                                                  .getOriginCoutries(widget
                                                      .tvshow
                                                      .originCountry[index]) !=
                                              null
                                          ? Text(Provider.of<TVShowProvider>(
                                                  context)
                                              .getOriginCoutries(widget
                                                  .tvshow.originCountry[index]))
                                          : Text(widget
                                              .tvshow.originCountry[index]));
                                },
                                itemCount: widget.tvshow.originCountry.length,
                              )
                            : Center(
                                child: Text('Not Available'),
                              ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Production Companies',
                          style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline6,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).accentColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: widget.tvshow.productionCompanies != null
                        ? widget.tvshow.productionCompanies.length != 0
                            ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 16),
                                    child: widget
                                                .tvshow
                                                .productionCompanies[index]
                                                .logoPath ==
                                            null
                                        ? Center(
                                            child: Text(widget
                                                    .tvshow
                                                    .productionCompanies[index]
                                                    .name +
                                                ' ' +
                                                widget
                                                    .tvshow
                                                    .productionCompanies[index]
                                                    .originCountry),
                                          )
                                        : Tooltip(
                                            message: widget
                                                    .tvshow
                                                    .productionCompanies[index]
                                                    .name +
                                                ' ' +
                                                widget
                                                    .tvshow
                                                    .productionCompanies[index]
                                                    .originCountry,
                                            child: CachedNetworkImage(
                                                imageUrl: baseUrl +
                                                    logoSize +
                                                    widget
                                                        .tvshow
                                                        .productionCompanies[
                                                            index]
                                                        .logoPath),
                                          ),
                                  );
                                },
                                itemCount:
                                    widget.tvshow.productionCompanies.length)
                            : Center(
                                child: Text('Not Available'),
                              )
                        : Container(
                            child: Text('Waiting...'),
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Networks',
                          style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline6,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).accentColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: widget.tvshow.productionCompanies != null
                        ? widget.tvshow.productionCompanies.length != 0
                            ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 16),
                                    child: widget.tvshow.networks[index]
                                                .logoPath ==
                                            null
                                        ? Center(
                                            child: Text(widget.tvshow
                                                    .networks[index].name +
                                                ' ' +
                                                widget.tvshow.networks[index]
                                                    .originCountry),
                                          )
                                        : Tooltip(
                                            message: widget.tvshow
                                                    .networks[index].name +
                                                ' ' +
                                                widget.tvshow.networks[index]
                                                    .originCountry,
                                            child: CachedNetworkImage(
                                              imageUrl: baseUrl +
                                                  logoSize +
                                                  widget.tvshow.networks[index]
                                                      .logoPath,
                                            ),
                                          ),
                                  );
                                },
                                itemCount: widget.tvshow.networks.length)
                            : Center(
                                child: Text('Not Available'),
                              )
                        : Container(
                            child: Text('Waiting...'),
                          ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).accentColor,
                    ),
                    child: InkWell(
                      onTap: widget.tvshow.externalIds != null
                          ? () => launch('http://www.imdb.com/title/' +
                              widget.tvshow.externalIds.imdbId +
                              '/parentalguide')
                          : () {},
                      child: Center(
                        child: Text(
                          'Parental Guide from IMDb',
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  widget.tvshow.recommendations != null
                      ? widget.tvshow.recommendations.results.length != 0
                          ? HorizontalListTVShow(
                              itemList: widget.tvshow.recommendations.results,
                              title: 'Recommendations',
                            )
                          : Container(
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: Text(
                                  'Recommendations Not Available',
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
                  widget.tvshow.credits != null
                      ? widget.tvshow.credits.crew.length != 0
                          ? HorizontalListCrew(
                              itemList: widget.tvshow.credits.crew,
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
                  widget.tvshow.similar != null
                      ? widget.tvshow.similar.results.length != 0
                          ? HorizontalListTVShow(
                              itemList: widget.tvshow.similar.results,
                              title: 'Similar Shows',
                            )
                          : Container(
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: Text(
                                  'Similar Shows Not Available',
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
                              textStyle: Theme.of(context).textTheme.headline6,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      )),
    ));
  }
}
