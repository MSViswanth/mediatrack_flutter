import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/movie.dart';
import 'package:mediatrack_flutter/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final Movie movie;
  final int index;
  DetailsScreen({this.movie, this.index});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isWaiting = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                        padding: EdgeInsets.all(15),
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
                      tag: 'Poster' + widget.index.toString(),
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
                    left: 20,
                    top: 20,
                    child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_left),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  //Release date Row
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(15),
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
                          Provider.of<MoviesProvider>(context).certification ==
                                  ''
                              ? Container()
                              : Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Text(
                                      Provider.of<MoviesProvider>(context)
                                          .certification),
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
    );
  }
}
