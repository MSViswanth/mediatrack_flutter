import 'package:json_annotation/json_annotation.dart';
import 'package:mediatrack_flutter/models/movie/movie.dart';

part 'collection.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
  explicitToJson: true,
)
class Collection {
  int id;
  String name;
  String overview;
  String posterPath;
  String backdropPath;
  List<Movie> parts;
  Collection(
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.parts,
  );
  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}
