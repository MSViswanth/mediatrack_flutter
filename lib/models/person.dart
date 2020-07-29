import 'package:json_annotation/json_annotation.dart';

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
  );
}
