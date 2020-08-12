import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/models/tvshow/season/season.dart';
import 'package:mediatrack_flutter/views/tvshow/season/episode/details_screen_episode.dart';

class PageViewEpisode extends StatefulWidget {
  final Season season;
  final int index;
  PageViewEpisode(this.season, this.index);
  @override
  _PageViewEpisodeState createState() => _PageViewEpisodeState();
}

class _PageViewEpisodeState extends State<PageViewEpisode> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return DetailsScreenEpisode(
          widget.season.episodes[index],
          widget.season.posterPath,
        );
      },
      controller: PageController(initialPage: widget.index),
      itemCount: widget.season.episodes.length,
    );
  }
}
