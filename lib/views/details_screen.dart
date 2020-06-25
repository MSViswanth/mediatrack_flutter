import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/movie.dart';
import 'package:mediatrack_flutter/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'package:mediatrack_flutter/components/horizontal_list.dart';

class DetailsScreen extends StatefulWidget {
  final Movie movie;
  final int index;
  DetailsScreen({this.movie, this.index});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  MoviesProvider resetDetailsProvider;
  @override
  void dispose() {
    resetDetailsProvider.resetDetails();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    resetDetailsProvider = Provider.of<MoviesProvider>(context, listen: false);

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 0.5 * size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    //Backdrop
                    width: size.width,
                    height: 0.4 * size.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.red],
                      ),
                      // color: Theme.of(context).accentColor,
                      image: DecorationImage(
                          image: widget.movie.backdropPath == null
                              ? NetworkImage(url)
                              : NetworkImage(baseUrl +
                                  backdropSize +
                                  widget.movie.backdropPath),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black87,
                          Colors.transparent,
                        ],
                      )),
                      child: Container(
                        //Title
                        width: 0.6 * size.width,
                        padding: EdgeInsets.all(16),
                        // margin: EdgeInsets.only(
                        //   left: 0.1 * size.width,
                        // ),
                        child: Text(
                          widget.movie.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Poster
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Hero(
                      tag: 'Poster' +
                          widget.index.toString() +
                          widget.movie.title,
                      child: Container(
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            baseUrl + posterSize + widget.movie.posterPath,
                            height: 200,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 20,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  //Release date Row
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      height: 0.1 * size.height,
                      width: 0.6 * size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('${widget.movie.releaseDate.substring(0, 4)}'),
                          widget.movie.runtime == null
                              ? Text('Waiting')
                              : Text('${widget.movie.runtime}' + ' min'),
                          widget.movie.voteAverage != 0
                              ? Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Color(0xffe4bb24),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(widget.movie.voteAverage.toString()),
                                  ],
                                )
                              : Text(
                                  'NR',
                                  style: TextStyle(color: Colors.grey),
                                ),
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(3)),
                            child: Text(Provider.of<MoviesProvider>(context)
                                        .certification ==
                                    ''
                                ? 'NR'
                                : Provider.of<MoviesProvider>(context)
                                    .certification),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Text(
                widget.movie.tagline != null
                    ? widget.movie.tagline == ''
                        ? 'No Tagline'
                        : widget.movie.tagline
                    : 'Waiting...',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Overview',
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Text(
                widget.movie.overview,
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Similar Movies',
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            widget.movie.similarMovies != null
                ? widget.movie.similarMovies.results.length != 0
                    ? HorizontalList(
                        itemList: widget.movie.similarMovies.results,
                      )
                    : Container(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'Not Available',
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
          ],
        ),
      ),
    );
  }
}
