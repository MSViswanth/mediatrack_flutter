import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediatrack_flutter/constants.dart';
import 'package:mediatrack_flutter/models/tvshow/season/season.dart';

import 'package:mediatrack_flutter/providers/tvshow/season/season_provider.dart';
import 'package:mediatrack_flutter/views/tvshow/season/details_screen_season.dart';
import 'package:provider/provider.dart';
import 'package:mediatrack_flutter/views/tvshow/details_screen_tv.dart';

class HorizontalListSeasons extends StatelessWidget {
  const HorizontalListSeasons({
    @required this.itemList,
    @required this.tvId,
    @required this.backdropPath,
    @required this.tvshowName,
  });

  final List<Season> itemList;
  final String title = 'Seasons';
  final int tvId;
  final String backdropPath;
  final String tvshowName;

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
          padding: EdgeInsets.all(5),
          height: 240,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                margin: EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreenSeason(
                            season: itemList[index],
                            backdropPath: backdropPath,
                            tvshowName: tvshowName,
                            tvId: tvId,
                          ),
                        ));
                  },
                  // onLongPress: () {
                  //   Provider.of<PersonProvider>(context, listen: false)
                  //       .updateDetails(itemList, index);
                  //   showModalBottomSheet(
                  //     context: context,
                  //     builder: (context) => BottomSheetQuickInfo(
                  //       movie: itemList[index],
                  //     ),
                  //   );
                  // },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
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
                                    fit: BoxFit.cover,
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
                      Text(
                        itemList[index].name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
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
