import 'package:json_annotation/json_annotation.dart';
part 'countries.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
  explicitToJson: true,
)
class Country {
  String iso_3166_1;
  String englishName;
  Country(
    this.iso_3166_1,
    this.englishName,
  );
  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

class CountriesList {
  List<Country> countries;
  CountriesList({
    this.countries,
  });
  factory CountriesList.fromJson(List<dynamic> json) {
    List<Country> countries = List<Country>();
    countries = json.map((i) => Country.fromJson(i)).toList();
    return CountriesList(
      countries: countries,
    );
  }
}
