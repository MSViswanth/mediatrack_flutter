import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/person/person.dart';

class DetailsScreenPerson extends StatefulWidget {
  DetailsScreenPerson({this.person});
  final Person person;
  @override
  _DetailsScreenPersonState createState() => _DetailsScreenPersonState();
}

class _DetailsScreenPersonState extends State<DetailsScreenPerson> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: widget.person.profilePath != null
                      ? CachedNetworkImageProvider(
                          baseUrl + posterSize + widget.person.profilePath,
                        )
                      : NetworkImage(url),
                  fit: BoxFit.cover,
                  colorFilter: widget.person.profilePath != null
                      ? ColorFilter.mode(Colors.black, BlendMode.screen)
                      : ColorFilter.mode(Colors.white, BlendMode.clear)),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: size.height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          stops: [0, 0.5, 1],
                          colors: [
                            Colors.transparent,
                            Colors.black26,
                            Colors.black87,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                        child: Text(
                          widget.person.name,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 60)),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: size.height,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
