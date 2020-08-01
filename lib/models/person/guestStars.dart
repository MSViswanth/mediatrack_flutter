import 'package:json_annotation/json_annotation.dart';
part 'guestStars.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
  explicitToJson: true,
)
class GuestStar {
  int id;
  String creditId;
  String name;
  String character;
  int order;
  int gender;
  String profilePath;

  GuestStar(this.id, this.creditId, this.name, this.character, this.order,
      this.gender, this.profilePath);

  factory GuestStar.fromJson(Map<String, dynamic> json) =>
      _$GuestStarFromJson(json);
  Map<String, dynamic> toJson() => _$GuestStarToJson(this);
}
