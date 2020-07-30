import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/movie/movie.dart';
import 'package:mediatrack_flutter/providers/movie/movie_provider.dart';
import 'package:mediatrack_flutter/views/home_page.dart';
import 'package:provider/provider.dart';
import 'package:mediatrack_flutter/components/movie/horizontal_list_movie.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreenMovie extends StatefulWidget {
  final Movie movie;
  DetailsScreenMovie({
    this.movie,
  });

  @override
  _DetailsScreenMovieState createState() => _DetailsScreenMovieState();
}

class _DetailsScreenMovieState extends State<DetailsScreenMovie> {
  MovieProvider resetDetailsProvider;

  @override
  void dispose() {
    resetDetailsProvider.resetDetails();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    resetDetailsProvider = Provider.of<MovieProvider>(context, listen: false);

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: widget.movie.posterPath != null
                  ? CachedNetworkImageProvider(
                      baseUrl + posterSize + widget.movie.posterPath,
                    )
                  : NetworkImage(url),
              fit: BoxFit.cover,
              colorFilter: widget.movie.posterPath != null
                  ? ColorFilter.mode(Colors.black, BlendMode.screen)
                  : ColorFilter.mode(Colors.white, BlendMode.clear)),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: Text(widget.movie.title),
                  floating: true,
                  expandedHeight: 0.3 * size.height,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.movie.backdropPath == null
                            ? NetworkImage(url) //TODO: Add placeholder.
                            : CachedNetworkImageProvider(
                                baseUrl +
                                    backdropSize +
                                    widget.movie.backdropPath,
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
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      Container(
                        padding: EdgeInsets.all(16),
                        height: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 0.6 * size.width,
                                  child: widget.movie.originalTitle != null
                                      ? Text(
                                          widget.movie.originalTitle +
                                              ' - ' +
                                              widget.movie.originalLanguage,
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      : Text(widget.movie.title),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      widget.movie.releaseDate != ''
                                          ? Text(
                                              '${DateTime.parse(widget.movie.releaseDate).year}',
                                              style: TextStyle(fontSize: 20),
                                            )
                                          : Text('Not Available'),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      widget.movie.runtime == null
                                          ? Container(
                                              width: 50,
                                              child: LinearProgressIndicator(),
                                            )
                                          : widget.movie.runtime != 0
                                              ? Text(
                                                  widget.movie.runtime ~/ 60 !=
                                                              0 &&
                                                          widget.movie.runtime %
                                                                  60 !=
                                                              0
                                                      ? '${widget.movie.runtime ~/ 60}hr ${widget.movie.runtime % 60}min'
                                                      : widget.movie.runtime ~/
                                                                  60 ==
                                                              0
                                                          ? '${widget.movie.runtime % 60}min'
                                                          : '${widget.movie.runtime ~/ 60}hr',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )
                                              : Text(''),
                                    ],
                                  ),
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
                                  child: widget.movie.posterPath != null
                                      ? CachedNetworkImage(
                                          imageUrl: baseUrl +
                                              posterSize +
                                              widget.movie.posterPath,
                                          progressIndicatorBuilder:
                                              (context, url, progress) =>
                                                  Container(
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
                                              style:
                                                  TextStyle(color: Colors.grey),
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
                            widget.movie.status != null
                                ? Text(
                                    widget.movie.status,
                                    style: TextStyle(fontSize: 16),
                                  )
                                : Container(
                                    width: 50,
                                    child: LinearProgressIndicator(),
                                  ),
                            // SizedBox.shrink(),
                            widget.movie.voteAverage != 0
                                ? Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.star,
                                        color: Color(0xffe4bb24),
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        widget.movie.voteAverage.toString(),
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
                            // SizedBox.shrink(),
                            Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .color,
                                  ),
                                  borderRadius: BorderRadius.circular(3)),
                              child: Text(Provider.of<MovieProvider>(context)
                                              .certification ==
                                          '' ||
                                      Provider.of<MovieProvider>(context)
                                              .certification ==
                                          null
                                  ? 'NR'
                                  : Provider.of<MovieProvider>(context)
                                      .certification),
                            ),
                            // SizedBox.shrink(),
                            // Text(widget.movie.voteCount.toString() + ' votes'),
                            GestureDetector(
                              onTap: widget.movie.imdbId != null
                                  ? () => launch(
                                        'http://www.imdb.com/title/' +
                                            widget.movie.imdbId,
                                      )
                                  : () {},
                              child: Image.asset(
                                'assets/images/imdb.png',
                                scale: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      widget.movie.homepage != null &&
                              widget.movie.homepage != ''
                          ? Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(16),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context).accentColor,
                              ),
                              child: InkWell(
                                onTap: () => launch(widget.movie.homepage),
                                child: Center(
                                  child: Text(
                                    '\'' +
                                        widget.movie.title +
                                        '\'' +
                                        ' Website',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(16),
                          child: widget.movie.tagline != null
                              ? widget.movie.tagline == ''
                                  ? Text(
                                      'No Tagline',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      widget.movie.tagline,
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                              : Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                )),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        child: Text(
                          widget.movie.overview,
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
                                textStyle:
                                    Theme.of(context).textTheme.headline6,
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
                        child: widget.movie.genres != null
                            ? widget.movie.genres.length == 0
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
                                    itemCount: widget.movie.genres.length,
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          '${widget.movie.genres[genre].name}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      );
                                    })
                            : Text('Waiting...'),
                      ),
                      widget.movie.belongsToCollection != null
                          ? Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'From Collection',
                                style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.headline6,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            )
                          : Container(),
                      widget.movie.belongsToCollection != null
                          ? Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 0,
                                  ),
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
                                    aspectRatio: 16 / 9,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: widget.movie.belongsToCollection
                                                  .backdropPath !=
                                              null
                                          ? CachedNetworkImage(
                                              imageUrl: baseUrl +
                                                  backdropSize +
                                                  widget
                                                      .movie
                                                      .belongsToCollection
                                                      .backdropPath,
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
                                Container(
                                  margin: EdgeInsets.all(16),
                                  child: Text(
                                      widget.movie.belongsToCollection.name),
                                ),
                              ],
                            )
                          : Container(),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Spoken Languages',
                              style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.headline6,
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
                        child: widget.movie.spokenLanguages == null
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: EdgeInsets.only(right: 16),
                                      child: Text(widget
                                          .movie.spokenLanguages[index].name));
                                },
                                itemCount: widget.movie.spokenLanguages.length,
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Production Countries',
                              style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.headline6,
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
                        child: widget.movie.productionCountries == null
                            ? Center(child: Text('Waiting'))
                            : widget.movie.productionCountries.length != 0
                                ? ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(widget
                                              .movie
                                              .productionCountries[index]
                                              .name));
                                    },
                                    itemCount:
                                        widget.movie.productionCountries.length,
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
                                textStyle:
                                    Theme.of(context).textTheme.headline6,
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
                        margin: EdgeInsets.all(16),
                        child: widget.movie.productionCompanies != null
                            ? widget.movie.productionCompanies.length != 0
                                ? ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(right: 16),
                                        child: widget
                                                    .movie
                                                    .productionCompanies[index]
                                                    .logoPath ==
                                                null
                                            ? Center(
                                                child: Text(widget
                                                        .movie
                                                        .productionCompanies[
                                                            index]
                                                        .name +
                                                    ' ' +
                                                    widget
                                                        .movie
                                                        .productionCompanies[
                                                            index]
                                                        .originCountry),
                                              )
                                            : Tooltip(
                                                message: widget
                                                        .movie
                                                        .productionCompanies[
                                                            index]
                                                        .name +
                                                    ' ' +
                                                    widget
                                                        .movie
                                                        .productionCompanies[
                                                            index]
                                                        .originCountry,
                                                child: Image.network(baseUrl +
                                                    logoSize +
                                                    widget
                                                        .movie
                                                        .productionCompanies[
                                                            index]
                                                        .logoPath),
                                              ),
                                      );
                                    },
                                    itemCount:
                                        widget.movie.productionCompanies.length)
                                : Center(
                                    child: Text('Not Available'),
                                  )
                            : Container(
                                child: Text('Waiting'),
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
                          onTap: widget.movie.imdbId != null
                              ? () => launch('http://www.imdb.com/title/' +
                                  widget.movie.imdbId +
                                  '/parentalguide')
                              : () {},
                          child: Center(
                            child: Text(
                              'Parental Guide from IMDb',
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      widget.movie.recommendations != null
                          ? widget.movie.recommendations.results.length != 0
                              ? HorizontalListMovie(
                                  itemList:
                                      widget.movie.recommendations.results,
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
                      widget.movie.similarMovies != null
                          ? widget.movie.similarMovies.results.length != 0
                              ? HorizontalListMovie(
                                  itemList: widget.movie.similarMovies.results,
                                  title: 'More like this',
                                )
                              : Container(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: Text(
                                      'Similar Movies Not Available',
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
