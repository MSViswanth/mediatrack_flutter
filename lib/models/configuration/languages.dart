import 'package:json_annotation/json_annotation.dart';
part 'languages.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
  explicitToJson: true,
)
class Language {
  String iso_639_1;
  String englishName;
  String name;
  Language(
    this.iso_639_1,
    this.englishName,
    this.name,
  );
  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}

class LanguagesList {
  List<Language> languages;
  LanguagesList({
    this.languages,
  });
  factory LanguagesList.fromJson(List<dynamic> json) {
    List<Language> languages = List<Language>();
    languages = json.map((i) => Language.fromJson(i)).toList();
    return LanguagesList(
      languages: languages,
    );
  }
}
