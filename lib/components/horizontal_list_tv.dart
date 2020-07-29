import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/show.dart';
import 'package:mediatrack_flutter/providers/tv_provider.dart';
import 'package:provider/provider.dart';
import 'package:mediatrack_flutter/views/details_screen_tv.dart';

class HorizontalListTV extends StatelessWidget {
  const HorizontalListTV({
    @required this.itemList,
  });

  final List<Show> itemList;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(5),
      height: 200,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
//           Provider.of<TVProvider>(context, listen: false)
//               .updateDetails(itemList[index], index);
//           String name = popularMovies[index].title;

          // print(index);

          return Container(
            margin: EdgeInsets.all(8),
            child: GestureDetector(
               onTap: () {
                 Provider.of<TVProvider>(context, listen: false)
                     .updateDetails(itemList, index);
                 Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => DetailsScreenTv(
                         show: itemList[index],
                         index: index,
                       ),
                     ));
               },
//               onLongPress: () {
//                 Provider.of<TVProvider>(context, listen: false)
//                     .updateDetails(itemList, index);
//                 showModalBottomSheet(
//                   context: context,
//                   builder: (context) => BottomSheetQuickInfo(
//                     movie: itemList[index],
//                   ),
//                 );
//               },
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
                              color: Theme.of(context).scaffoldBackgroundColor,
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
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    itemList[index].name,
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
    );
  }
}
