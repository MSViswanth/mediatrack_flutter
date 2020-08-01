import 'package:json_annotation/json_annotation.dart';
import '../movie/movie.dart';
import '../tvshow/tvshow.dart';

part 'person.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
  explicitToJson: true,
)
class Person {
  String birthday;
  String knownForDepartment;
  String deathday;
  int id;
  String name;
  List<String> alsoKnownAs;
  int gender;
  String biography;
  double popularity;
  String placeOfBirth;
  String profilePath;
  bool adult;
  String imdbId;
  String homepage;
  String mediaType = 'person';
  List<PersonCreditMovies> movieCredits;
  List<PersonCreditTVShows> tvCredits;

  Person(
    this.birthday,
    this.knownForDepartment,
    this.deathday,
    this.id,
    this.name,
    this.alsoKnownAs,
    this.gender,
    this.biography,
    this.popularity,
    this.placeOfBirth,
    this.profilePath,
    this.adult,
    this.imdbId,
    this.homepage,
    this.mediaType,
    this.movieCredits,
    this.tvCredits,
  );

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
  explicitToJson: true,
)
class PersonCreditMovies {
  int id;
  List<Movie> cast;
  List<Movie> crew;

  PersonCreditMovies(this.cast, this.crew, this.id);
  factory PersonCreditMovies.fromJson(Map<String, dynamic> json) =>
      _$PersonCreditMoviesFromJson(json);
  Map<String, dynamic> toJson() => _$PersonCreditMoviesToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
  explicitToJson: true,
)
class PersonCreditTVShows {
  int id;
  List<TVShow> cast;
  List<TVShow> crew;

  PersonCreditTVShows(this.cast, this.crew, this.id);
  factory PersonCreditTVShows.fromJson(Map<String, dynamic> json) =>
      _$PersonCreditTVShowsFromJson(json);
  Map<String, dynamic> toJson() => _$PersonCreditTVShowsToJson(this);
}
