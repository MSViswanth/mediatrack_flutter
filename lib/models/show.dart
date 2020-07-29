import 'package:json_annotation/json_annotation.dart';
import 'movie.dart';
part 'show.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
  explicitToJson: true,
)

class Show{
  String backdropPath;
  List<CreatedBy> createdBy;
  List<EpisodeRunTime> episodeRunTime;
  String firstAirDate;
  List<Genres> genres;
  List<Languages> languages;
  String lastAirDate;

}
