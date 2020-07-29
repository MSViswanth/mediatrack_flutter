import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/show.dart';
import 'package:mediatrack_flutter/providers/tv_provider.dart';
import 'package:provider/provider.dart';
import 'package:mediatrack_flutter/components/horizontal_list_tv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mediatrack_flutter/views/home_page.dart';



class DetailsScreenTv extends StatefulWidget {
  final Show show;
  final int index;
  DetailsScreenTv({this.show, this.index});
  @override
  _DetailsScreenTvState createState() => _DetailsScreenTvState();
}

class _DetailsScreenTvState extends State<DetailsScreenTv> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: widget.show.posterPath != null
                    ? NetworkImage(
                  baseUrl + posterSize + widget.show.posterPath,
                )
                    : NetworkImage(url),
                fit: BoxFit.cover,
                colorFilter: widget.show.posterPath != null
                    ? ColorFilter.mode(Colors.black, BlendMode.screen)
                    : ColorFilter.mode(Colors.white, BlendMode.clear)),
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: CustomScrollView(
                  slivers: <Widget>[
              SliverAppBar(
              title: Text(widget.show.name),
              floating: true,
              expandedHeight: 0.3 * size.height,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.show.backdropPath == null
                        ? NetworkImage(url) //TODO: Add placeholder.
                        : CachedNetworkImageProvider(
                      baseUrl +
                          backdropSize +
                          widget.show.backdropPath,
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
            )
          ),
        )
    );
  }
}

