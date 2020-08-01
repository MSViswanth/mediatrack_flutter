import 'package:json_annotation/json_annotation.dart';
import 'package:mediatrack_flutter/models/person/cast.dart';
import 'package:mediatrack_flutter/models/person/crew.dart';

part 'credits.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
  explicitToJson: true,
)
class Credits {
  int id;
  List<Cast> cast;
  List<Crew> crew;

  Credits(
    this.id,
    this.cast,
    this.crew,
  );
  factory Credits.fromJson(Map<String, dynamic> json) =>
      _$CreditsFromJson(json);
  Map<String, dynamic> toJson() => _$CreditsToJson(this);
}
