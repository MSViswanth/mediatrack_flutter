import 'package:json_annotation/json_annotation.dart';
import 'package:mediatrack_flutter/models/person/cast.dart';
import 'package:mediatrack_flutter/models/person/crew.dart';

part 'movie.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
  explicitToJson: true,
)
class Movie {
  bool adult;
  String backdropPath;
  BelongsToCollection belongsToCollection;
  int budget;
  List<Genres> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompanies> productionCompanies;
  List<ProductionCountries> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguages> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  String mediaType = 'movie';
  ReleaseDatesParent releaseDates;
  SimilarMovies similarMovies;
  Recommendations recommendations;
  Credits credits;

  Movie(
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.mediaType,
    this.releaseDates,
    this.similarMovies,
    this.recommendations,
  );
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class BelongsToCollection {
  int id;
  String name;
  String posterPath;
  String backdropPath;
  BelongsToCollection(
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  );
  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$BelongsToCollectionToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class Genres {
  int id;
  String name;
  Genres(
    this.id,
    this.name,
  );
  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);
  Map<String, dynamic> toJson() => _$GenresToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class ProductionCompanies {
  String name;
  int id;
  String logoPath;
  String originCountry;
  ProductionCompanies(
    this.name,
    this.id,
    this.logoPath,
    this.originCountry,
  );
  factory ProductionCompanies.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompaniesFromJson(json);
  Map<String, dynamic> toJson() => _$ProductionCompaniesToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class ProductionCountries {
  String iso_3166_1;
  String name;
  ProductionCountries(
    this.iso_3166_1,
    this.name,
  );
  factory ProductionCountries.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountriesFromJson(json);
  Map<String, dynamic> toJson() => _$ProductionCountriesToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class SpokenLanguages {
  String iso_639_1;
  String name;
  SpokenLanguages(
    this.iso_639_1,
    this.name,
  );
  factory SpokenLanguages.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguagesFromJson(json);
  Map<String, dynamic> toJson() => _$SpokenLanguagesToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class ReleaseDatesParent {
  List<ReleaseDateResults> results;
  ReleaseDatesParent(
    this.results,
  );
  factory ReleaseDatesParent.fromJson(Map<String, dynamic> json) =>
      _$ReleaseDatesParentFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseDatesParentToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class ReleaseDateResults {
  String iso_3166_1;
  List<ReleaseDates> releaseDates;
  ReleaseDateResults(
    this.iso_3166_1,
    this.releaseDates,
  );
  factory ReleaseDateResults.fromJson(Map<String, dynamic> json) =>
      _$ReleaseDateResultsFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseDateResultsToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class ReleaseDates {
  String certification;
  String iso_639_1;
  String note;
  String releaseDate;
  int type;
  ReleaseDates(
    this.certification,
    this.iso_639_1,
    this.note,
    this.releaseDate,
    this.type,
  );
  factory ReleaseDates.fromJson(Map<String, dynamic> json) =>
      _$ReleaseDatesFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseDatesToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class SimilarMovies {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;
  SimilarMovies(
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  );

  factory SimilarMovies.fromJson(Map<String, dynamic> json) =>
      _$SimilarMoviesFromJson(json);
  Map<String, dynamic> toJson() => _$SimilarMoviesToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class Recommendations {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;
  Recommendations(
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  );

  factory Recommendations.fromJson(Map<String, dynamic> json) =>
      _$RecommendationsFromJson(json);
  Map<String, dynamic> toJson() => _$RecommendationsToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
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
