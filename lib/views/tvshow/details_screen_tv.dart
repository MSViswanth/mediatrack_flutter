import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/tvshow/tvshow.dart';
import 'package:mediatrack_flutter/providers/tvshow/tvshow_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mediatrack_flutter/views/home_page.dart';
import 'package:mediatrack_flutter/components/tvshow/season/horizontal_list_season.dart';
import 'package:mediatrack_flutter/components/tvshow/horizontal_list_tvshow.dart';

class DetailsScreenTVShow extends StatefulWidget {
  final TVShow tvshow;
  final int index;
  DetailsScreenTVShow({this.tvshow, this.index});
  @override
  _DetailsScreenTVShowState createState() => _DetailsScreenTVShowState();
}

class _DetailsScreenTVShowState extends State<DetailsScreenTVShow> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: widget.tvshow.posterPath != null
                ? CachedNetworkImageProvider(
                    baseUrl + posterSize + widget.tvshow.posterPath,
                  )
                : NetworkImage(url),
            fit: BoxFit.cover,
            colorFilter: widget.tvshow.posterPath != null
                ? ColorFilter.mode(Colors.black, BlendMode.screen)
                : ColorFilter.mode(Colors.white, BlendMode.clear)),
      ),
      child: ClipRect(
          child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(widget.tvshow.name),
              floating: true,
              expandedHeight: 0.3 * size.height,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.tvshow.backdropPath == null
                        ? NetworkImage(url) //TODO: Add placeholder.
                        : CachedNetworkImageProvider(
                            baseUrl + backdropSize + widget.tvshow.backdropPath,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end, //TODO
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 0.6 * size.width,
                            child: widget.tvshow.originalName != null &&
                                    widget.tvshow.originalLanguage != null
                                ? Text(
                                    widget.tvshow.originalName +
                                        ' - ' +
                                        widget.tvshow.originalLanguage,
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              widget.tvshow.firstAirDate != ''
                                  ? Text(
                                      '${DateTime.parse(widget.tvshow.firstAirDate).year}' +
                                          '  -  ' +
                                          '${widget.tvshow.status == 'Ended' ? DateTime.parse(widget.tvshow.lastEpisodeToAir.airDate).year : 'Present'}',
                                      style: TextStyle(fontSize: 18),
                                    )
                                  : Text('Not Available'),
                              SizedBox(
                                width: 20,
                              ),
                              widget.tvshow.voteAverage != 0
                                  ? Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          color: Color(0xff90cea1),
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          widget.tvshow.voteAverage.toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      'NR',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 0.6 * size.width,
                            child: widget.tvshow.seasons != null
                                ? Text(
                                    '${widget.tvshow.numberOfEpisodes} Episodes',
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        ],
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
                      widget.tvshow.status != null
                          ? Text(
                              widget.tvshow.status,
                              style: TextStyle(fontSize: 16),
                            )
                          : Container(
                              width: 50,
                              child: LinearProgressIndicator(),
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
                                              widget.tvshow.episodeRunTime[0] %
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
//                          child: Text(Provider.of<MovieProvider>(context)
//                              .certification ==
//                              '' ||
//                              Provider.of<MovieProvider>(context)
//                                  .certification ==
//                                  null
//                              ? 'NR'
//                              : Provider.of<MovieProvider>(context)
//                              .certification),
                        child: Text('TV-MA'),
                      ),
                      GestureDetector(
                        onTap: () {},
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
                widget.tvshow.seasons != null
                    ? widget.tvshow.seasons.length != 0
                        ? HorizontalListSeasons(
                            itemList: widget.tvshow.seasons,
                          )
                        : Container(
                            padding: EdgeInsets.all(16),
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
                      ? Center(child: Text('Waiting...'))
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.only(right: 16),
                                child: Text(widget.tvshow.languages[index]));
                          },
                          itemCount: widget.tvshow.languages.length,
                        ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Production Countries',
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
                      ? Center(child: Text('Waiting'))
                      : widget.tvshow.originCountry.length != 0
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                        widget.tvshow.originCountry[index]));
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
                                          child: Image.network(baseUrl +
                                              logoSize +
                                              widget
                                                  .tvshow
                                                  .productionCompanies[index]
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
                          child: Text('Waiting'),
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
                GestureDetector(
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
      )),
    ));
  }
}
