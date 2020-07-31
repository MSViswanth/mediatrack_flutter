import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediatrack_flutter/components/movie/horizontal_list_movie.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/movie/collection/collection.dart';
import 'package:mediatrack_flutter/views/home_page.dart';
import 'package:mediatrack_flutter/views/movie/details_screen_movie.dart';

class DetailsScreenCollection extends StatefulWidget {
  final int collectionId;
  DetailsScreenCollection(this.collectionId);
  @override
  _DetailsScreenCollectionState createState() =>
      _DetailsScreenCollectionState();
}

class _DetailsScreenCollectionState extends State<DetailsScreenCollection> {
  Collection collection;
  @override
  void initState() {
    super.initState();
    collectionProvider.getDetails(widget.collectionId);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    collection = collectionProvider.collection;
    return Scaffold(
      body: collection != null
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: collection.posterPath != null
                      ? CachedNetworkImageProvider(
                          baseUrl + posterSize + collection.posterPath,
                        )
                      : NetworkImage(url), //TODO: Add Placeholder
                  fit: BoxFit.cover,
                  colorFilter: collection.posterPath != null
                      ? ColorFilter.mode(Colors.black, BlendMode.screen)
                      : ColorFilter.mode(Colors.white, BlendMode.clear),
                ),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        floating: true,
                        expandedHeight: 0.3 * size.height,
                        flexibleSpace: collection.backdropPath != null
                            ? Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        baseUrl +
                                            backdropSize +
                                            collection.backdropPath,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    gradient: LinearGradient(
                                        colors: [Colors.teal, Colors.blue])),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [Colors.teal, Colors.blue])),
                                padding: EdgeInsets.all(3),
                                child: Center(
                                    child: Text(
                                  'Image not available',
                                  textAlign: TextAlign.center,
                                )),
                              ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          <Widget>[
                            Container(
                              padding: EdgeInsets.all(16),
                              height: 200,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 0.6 * size.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          collection.name,
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            '${collection.parts.length} movies',
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
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
                                        child: collection.posterPath != null
                                            ? CachedNetworkImage(
                                                imageUrl: baseUrl +
                                                    posterSize +
                                                    collection.posterPath,
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
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                )),
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 16,
                                left: 16,
                                right: 16,
                                bottom: 0,
                              ),
                              child: Text(
                                'Overview',
                                style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.headline6,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: collection.overview != ''
                                  ? Text(
                                      collection.overview,
                                      style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    )
                                  : Text(
                                      'Not Available',
                                      style: GoogleFonts.lato(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          color: Colors.grey),
                                    ),
                            ),
                            HorizontalListMovie(
                                itemList: collection.parts, title: 'Movies'),
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
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
