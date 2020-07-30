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
              delegate: SliverChildListDelegate(
                <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround, //TODO
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 0.6 * size.width,
                              child: widget.tvshow.originalName != null && widget.tvshow.originalLanguage != null
                                  ? Text(
                                widget.tvshow.originalName+' - '+widget.tvshow.originalLanguage,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                                  : Text(widget.tvshow.name,
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
                                  '${DateTime.parse(widget.tvshow.firstAirDate).year}'+'  -  '+'${widget.tvshow.status=='Ended'? DateTime.parse(widget.tvshow.lastEpisodeToAir.airDate).year: 'Tomorrow'}',
                                  style: TextStyle(fontSize: 18),
                                )
                                    : Text('Not Available'),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
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
                        widget.tvshow.status != null
                            ? Text(
                          widget.tvshow.status,
                          style: TextStyle(fontSize: 16),
                        )
                            : Container(
                          width: 50,
                          child: LinearProgressIndicator(),
                        ),
                      ],
                    ),
                  )
                ]
              ),
            )
          ],
        ),
      )),
    ));
  }
}
