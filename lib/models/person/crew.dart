import 'package:json_annotation/json_annotation.dart';
part 'crew.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
  explicitToJson: true,
)
class Crew {
  int id;
  String creditId;
  String name;
  String department;
  String job;
  int gender;
  String profilePath;

  Crew(this.id, this.creditId, this.name, this.department, this.job,
      this.gender, this.profilePath);

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);
  Map<String, dynamic> toJson() => _$CrewToJson(this);
}
