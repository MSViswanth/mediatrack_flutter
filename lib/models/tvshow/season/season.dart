import 'package:json_annotation/json_annotation.dart';
import 'package:mediatrack_flutter/models/person/credits.dart';
import 'episode/episode.dart';
part 'season.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
  explicitToJson: true,
)
class Season {
  @JsonKey(name: '_id')
  String sId;
  String airDate;
  List<Episode> episodes;
  String name;
  String overview;
  int id;
  String posterPath;
  int seasonNumber;
  Credits credits;

  Season(
    this.sId,
    this.airDate,
    this.episodes,
    this.name,
    this.overview,
    this.id,
    this.posterPath,
    this.seasonNumber,
    this.credits,
  );

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
  Map<String, dynamic> toJson() => _$SeasonToJson(this);
}
