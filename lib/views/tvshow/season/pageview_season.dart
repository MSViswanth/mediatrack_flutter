import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/models/tvshow/tvshow.dart';
import 'package:mediatrack_flutter/views/tvshow/season/details_screen_season.dart';

class PageViewSeason extends StatefulWidget {
  final TVShow tvShow;
  final int index;
  PageViewSeason(this.tvShow, this.index);
  @override
  _PageViewSeasonState createState() => _PageViewSeasonState();
}

class _PageViewSeasonState extends State<PageViewSeason> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return DetailsScreenSeason(
          backdropPath: widget.tvShow.backdropPath,
          season: widget.tvShow.seasons[index],
          tvshowName: widget.tvShow.name,
          tvId: widget.tvShow.id,
        );
      },
      controller: PageController(
        initialPage: widget.index,
      ),
      itemCount: widget.tvShow.seasons.length,
    );
  }
}
