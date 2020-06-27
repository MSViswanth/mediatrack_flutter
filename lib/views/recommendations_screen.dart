import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/components/bottom_sheet_quick_info.dart';
import 'package:mediatrack_flutter/models/movie.dart';
import 'package:mediatrack_flutter/providers/movies_provider.dart';
import 'package:mediatrack_flutter/views/home.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'details_screen.dart';

class RecommendationsScreen extends StatelessWidget {
  RecommendationsScreen(this.recommendations);
  final List<Movie> recommendations;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
            ),
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
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
                    onTap: () {
                      Provider.of<MoviesProvider>(context, listen: false)
                          .updateDetails(recommendations, index);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              movie: recommendations[index],
                              index: index,
                            ),
                          ));
                    },
                    onLongPress: () {
                      Provider.of<MoviesProvider>(context, listen: false)
                          .updateDetails(recommendations, index);
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => BottomSheetQuickInfo(
                          movie: recommendations[index],
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'Poster' + recommendations[index].title,
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
