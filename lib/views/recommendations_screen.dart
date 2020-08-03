import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/components/movie/bottom_sheet_quick_info_movie.dart';
import 'package:mediatrack_flutter/models/movie/movie.dart';
import 'package:mediatrack_flutter/models/tvshow/tvshow.dart';
import 'package:mediatrack_flutter/providers/movie/movie_provider.dart';
import 'package:mediatrack_flutter/providers/tvshow/tvshow_provider.dart';
import 'package:mediatrack_flutter/views/home_page.dart';
import 'package:mediatrack_flutter/views/movie/details_screen_movie.dart';
import 'package:mediatrack_flutter/views/home.dart';
import 'package:mediatrack_flutter/views/tvshow/details_screen_tv.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class RecommendationsScreen extends StatelessWidget {
  RecommendationsScreen({this.boolMovie});
  final boolMovie;
  int i = 1;

  @override
  Widget build(BuildContext context) {
    List recommendations;
    if (boolMovie == true) {
      if (i < 100) {
        Provider.of<MovieProvider>(context).getPopular(i);
        i += 1;
      }
      MovieProvider moviesProvider = Provider.of<MovieProvider>(context);
      recommendations = moviesProvider.popularMovies;
      //print(recommendations);
    } else {
      if (i < 100) {
        Provider.of<TVShowProvider>(context).getPopular(i);
        i += 1;
      }
      TVShowProvider tvShowProvider = Provider.of<TVShowProvider>(context);
      recommendations = tvShowProvider.popularTVShows;
    }

    return Scaffold(
      appBar: AppBar(
        title: boolMovie == true
            ? Text('Popular Movies')
            : Text('Popular TV Shows'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
            ),
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
              (Route<dynamic> route) => false,
            ),
          )
        ],
      ),
      body: recommendations.length != 0
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 2 / 3),
              itemBuilder: (context, index) {
                return Container(
                  // height: 200,
                  // width: MediaQuery.of(context).size.width / 3,
                  margin: EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: boolMovie == true
                        ? () {
                            Provider.of<MovieProvider>(context, listen: false)
                                .updateDetails(recommendations, index);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreenMovie(
                                    movie: recommendations[index],
                                  ),
                                ));
                          }
                        : () {
                            Provider.of<TVShowProvider>(context, listen: false)
                                .updateDetails(recommendations, index);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreenTVShow(
                                    tvshow: recommendations[index],
                                  ),
                                ));
                          },
                    onLongPress: boolMovie == true
                        ? () {
                            Provider.of<MovieProvider>(context, listen: false)
                                .updateDetails(recommendations, index);
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => BottomSheetQuickInfoMovie(
                                movie: recommendations[index],
                              ),
                            );
                          }
                        : () {},
                    child: Hero(
                      tag: (boolMovie == true)
                          ? 'Poster' + recommendations[index].title
                          : recommendations[index].name,
                      child: Container(
                        // height: 180,
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
                            //Removed Aspect Ratio. Add if necessary.
                            borderRadius: BorderRadius.circular(12),
                            child: recommendations[index].posterPath != null
                                ? CachedNetworkImage(
                                    imageUrl: baseUrl +
                                        posterSize +
                                        recommendations[index].posterPath,
                                    progressIndicatorBuilder:
                                        (context, url, progress) => Container(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
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
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox.shrink(),
                                        Material(
                                          child: Text(
                                            'Image not available',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Material(
                                          child: Text(
                                            recommendations[index].title,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: recommendations.length,
            )
          : Center(
              child: Text('Not Available'),
            ),
    );
  }
}
