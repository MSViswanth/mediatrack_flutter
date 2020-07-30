import 'package:json_annotation/json_annotation.dart';
import '../movie/movie.dart';
part 'tvshow.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
  explicitToJson: true,
)
class TVShow {
  String backdropPath;
  List<CreatedBy> createdBy;
  List<int> episodeRunTime;
  String firstAirDate;
  List<Genres> genres;
  String homepage;
  int id;
  bool inProduction;
  List<String> languages;
  String lastAirDate;
  LastEpisodeToAir lastEpisodeToAir;
  String name;
  String nextEpisodeToAir;
  List<Networks> networks;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompanies> productionCompanies;
  List<Seasons> seasons;
  String status;
  String type;
  double voteAverage;
  int voteCount;
  String mediaType = 'tv';
  SimilarTVShows similarTVShows;
  RecommendationsTV recommendationsTV;

  TVShow(
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originalName,
    this.originCountry,
    this.originalLanguage,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.seasons,
    this.status,
    this.type,
    this.voteAverage,
    this.voteCount,
    this.mediaType,
      this.similarTVShows,
      this.recommendationsTV,
  );

  factory TVShow.fromJson(Map<String, dynamic> json) => _$TVShowFromJson(json);
  Map<String, dynamic> toJson() => _$TVShowToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class CreatedBy {
  int id;
  String creditId;
  String name;
  int gender;
  String profilePath;

  CreatedBy(
    this.name,
    this.id,
    this.creditId,
    this.gender,
    this.profilePath,
  );

  factory CreatedBy.fromJson(Map<String, dynamic> json) =>
      _$CreatedByFromJson(json);
  Map<String, dynamic> toJson() => _$CreatedByToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class LastEpisodeToAir {
  String airDate;
  int episodeNumber;
  int id;
  String name;
  String overview;
  String productionCode;
  int seasonNumber;
  int showId;
  String stillPath;
  double voteAverage;
  int voteCount;

  LastEpisodeToAir(
    this.id,
    this.name,
    this.voteCount,
    this.voteAverage,
    this.overview,
    this.airDate,
    this.episodeNumber,
    this.productionCode,
    this.seasonNumber,
    this.showId,
    this.stillPath,
  );

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) =>
      _$LastEpisodeToAirFromJson(json);
  Map<String, dynamic> toJson() => _$LastEpisodeToAirToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class Networks {
  String name;
  int id;
  String logoPath;
  String originCountry;

  Networks(this.name, this.id, this.originCountry, this.logoPath);

  factory Networks.fromJson(Map<String, dynamic> json) =>
      _$NetworksFromJson(json);
  Map<String, dynamic> toJson() => _$NetworksToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class Seasons {
  String airDate;
  int episodeCount;
  int id;
  String name;
  String overview;
  String posterPath;
  int seasonNumber;

  Seasons(
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
  );

  factory Seasons.fromJson(Map<String, dynamic> json) =>
      _$SeasonsFromJson(json);
  Map<String, dynamic> toJson() => _$SeasonsToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class SimilarTVShows {
  int page;
  List<TVShow> results;
  int totalPages;
  int totalResults;
  SimilarTVShows(
      this.page,
      this.results,
      this.totalPages,
      this.totalResults,
      );

  factory SimilarTVShows.fromJson(Map<String, dynamic> json) =>
      _$SimilarTVShowsFromJson(json);
  Map<String, dynamic> toJson() => _$SimilarTVShowsToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class RecommendationsTV {
  int page;
  List<TVShow> results;
  int totalPages;
  int totalResults;
  RecommendationsTV(
      this.page,
      this.results,
      this.totalPages,
      this.totalResults,
      );

  factory RecommendationsTV.fromJson(Map<String, dynamic> json) =>
      _$RecommendationsTVFromJson(json);
  Map<String, dynamic> toJson() => _$RecommendationsTVToJson(this);
}