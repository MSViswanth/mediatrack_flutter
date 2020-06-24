import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/components/bottom_sheet_quick_info.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/movie.dart';
import 'package:mediatrack_flutter/providers/movies_provider.dart';
import 'package:mediatrack_flutter/views/details_screen.dart';
import 'package:provider/provider.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    Key key,
    @required this.isWaiting,
    @required this.itemList,
  }) : super(key: key);

  final bool isWaiting;
  final List<Movie> itemList;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(5),
      height: 200,
      child: isWaiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // Provider.of<MoviesProvider>(context, listen: false)
                //     .updateDetails(itemList[index], index);
                // String name = popularMovies[index].title;

                // print(index);

                return Container(
                  padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<MoviesProvider>(context, listen: false)
                          .updateDetails(itemList[index], index);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              movie: itemList[index],
                              index: index,
                            ),
                          ));
                    },
                    onLongPress: () {
                      Provider.of<MoviesProvider>(context, listen: false)
                          .updateDetails(itemList[index], index);
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => BottomSheetQuickInfo(
                          movie: itemList[index],
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'Poster' + index.toString(),
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
                          child: Image.network(baseUrl +
                              posterSize +
                              itemList[index].posterPath),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: itemList.length,
            ),
    );
  }
}
