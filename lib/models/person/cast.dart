import 'package:json_annotation/json_annotation.dart';
part 'cast.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
  explicitToJson: true,
)
class Cast {
  int id;
  String creditId;
  String name;
  String character;
  int order;
  int gender;
  String profilePath;

  Cast(this.id, this.creditId, this.name, this.character, this.order,
      this.gender, this.profilePath);

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
  Map<String, dynamic> toJson() => _$CastToJson(this);
}
