import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/person/person.dart';
import 'package:mediatrack_flutter/providers/person/person_provider.dart';
import 'package:provider/provider.dart';
import 'red_more_text.dart';

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
            physics: BouncingScrollPhysics(),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.person.knownForDepartment,
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(fontSize: 20)),
                            ),
                            Text(
                              widget.person.name,
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(fontSize: 60)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  // height: size.height,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                      child: Container(
                        // width: size.width,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Row(
                                children: <Widget>[
                                  //TODO: Birthday can be null, adjust value accordingly id 196735
                                  widget.person.birthday != null
                                      ? widget.person.birthday != ''
                                          ? Text(
                                              DateFormat.yMMMd().format(
                                                      DateTime.parse(widget
                                                          .person.birthday)) +
                                                  ' - ',
                                              style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              child: Text(
                                                'Unknown - ',
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            )
                                      : Container(
                                          child: Text(
                                            'Unknown - ',
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                  widget.person.deathday != null
                                      ? widget.person.deathday != ''
                                          ? Text(
                                              DateFormat.yMMMd().format(
                                                    DateTime.parse(
                                                        widget.person.deathday),
                                                  ) +
                                                  ' ',
                                              style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            )
                                          : Text(
                                              'Present ',
                                              style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            )
                                      : Text(
                                          'Present ',
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            widget.person.birthday != null
                                ? Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      widget.person.deathday != null
                                          ? '(${DateTime.parse(widget.person.deathday).year - DateTime.parse(widget.person.birthday).year} years old)'
                                          : '(${DateTime.now().year - DateTime.parse(widget.person.birthday).year} years old)',
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  )
                                : Container(),
                            widget.person.biography != null
                                ? widget.person.biography != ''
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            top: 16,
                                            bottom: 0),
                                        child: Text(
                                          'Bio',
                                          style: GoogleFonts.lato(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                      )
                                    : Container()
                                : Container(),
                            widget.person.biography != null
                                ? widget.person.biography != ''
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 16),
                                        child: ReadMoreText(
                                          widget.person.biography,
                                          trimLines: 5,
                                          colorClickableText:
                                              Colors.greenAccent,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: '...Show more',
                                          trimExpandedText: ' show less',
                                          style: GoogleFonts.lato(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        ),
//                                        Text(
//                                          widget.person.biography,
//                                          style: GoogleFonts.lato(
//                                            textStyle: Theme.of(context)
//                                                .textTheme
//                                                .bodyText2,
//                                          ),
//                                        ),
                                      )
                                    : Container()
                                : Container(
                                    height: 30,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                          ],
                        ),
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
