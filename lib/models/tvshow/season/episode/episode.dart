import 'package:json_annotation/json_annotation.dart';
part 'episode.g.dart';


@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class Episode {
  String airDate;
  List<Crew> crew;
  int episodeNumber;
  List<Crew> guestStars;
  String name;
  String overview;
  int id;
  String productionCode;
  int seasonNumber;
  String stillPath;
  double voteAverage;
  int voteCount;

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
      this.voteCount
      );

  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class Crew {
  int id;
  String creditId;
  String name;
  String department;
  String job;
  String profilePath;

  Crew(
      this.id,
      this.creditId,
      this.name,
      this.department,
      this.job,
      this.profilePath
      );

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);
  Map<String, dynamic> toJson() => _$CrewToJson(this);
}