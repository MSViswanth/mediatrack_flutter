import 'package:json_annotation/json_annotation.dart';
import 'package:mediatrack_flutter/models/person/cast.dart';
import 'package:mediatrack_flutter/models/person/credits.dart';
import '../../../person/crew.dart';
part 'episode.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class Episode {
  String airDate;
  List<Crew> crew;
  int episodeNumber;
  List<Cast> guestStars;
  String name;
  String overview;
  int id;
  String productionCode;
  int seasonNumber;
  String stillPath;
  double voteAverage;
  int voteCount;
  Credits credits;

  Episode(
    this.airDate,
    this.crew,
    this.episodeNumber,
    this.guestStars,
    this.name,
    this.overview,
    this.id,
    this.productionCode,
    this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
    this.credits,
  );

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}
