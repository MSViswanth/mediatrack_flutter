import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediatrack_flutter/components/movie/bottom_sheet_quick_info_movie.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/movie/movie.dart';
import 'package:mediatrack_flutter/providers/movie/movie_provider.dart';
import 'package:mediatrack_flutter/views/movie/details_screen_movie.dart';
import 'package:provider/provider.dart';

///Generates a horizontal list of items in a row.
///
/// It takes `Movie` Object as input.
class HorizontalListMovie extends StatelessWidget {
  const HorizontalListMovie({
    @required this.itemList,
    @required this.title,
  });

  final List<Movie> itemList;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Row(
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.headline6,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward,
                color: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
        Container(
          // color: Theme.of(context).scaffoldBackgroundColor,
          padding: EdgeInsets.all(5),
          height: 200,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    Provider.of<MovieProvider>(context, listen: false)
                        .updateDetails(itemList, index);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreenMovie(
                            movie: itemList[index],
                          ),
                        ));
                  },
                  onLongPress: () {
                    Provider.of<MovieProvider>(context, listen: false)
                        .updateDetails(itemList, index);
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => BottomSheetQuickInfoMovie(
                        movie: itemList[index],
                      ),
                    );
                  },
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
                      //Removed Aspect Ratio. Add if necessary.
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: 500 / 750,
                        child: itemList[index].posterPath != null
                            ? CachedNetworkImage(
                                imageUrl: baseUrl +
                                    posterSize +
                                    itemList[index].posterPath,
                                progressIndicatorBuilder:
                                    (context, url, progress) => Container(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
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
                                        itemList[index].title,
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
              );
            },
            itemCount: itemList.length,
          ),
        ),
      ],
    );
  }
}
