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
          ],
        ),
      )),
    ));
  }
}
