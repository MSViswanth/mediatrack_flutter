import 'package:json_annotation/json_annotation.dart';
import 'package:mediatrack_flutter/models/person/credits.dart';
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
  EpisodeToAir lastEpisodeToAir;
  String name;
  EpisodeToAir nextEpisodeToAir;
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
  SimilarTVShows similar;
  RecommendationsTV recommendations;
  ContentRatings contentRatings;
  ExternalIds externalIds;
  Credits credits;

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
    this.similar,
    this.recommendations,
    this.contentRatings,
    this.externalIds,
    this.credits,
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
class EpisodeToAir {
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

  EpisodeToAir(
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

  factory EpisodeToAir.fromJson(Map<String, dynamic> json) =>
      _$EpisodeToAirFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeToAirToJson(this);
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

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class ContentRatings {
  List<Rating> results;
  int id;
  ContentRatings(
    this.results,
    this.id,
  );
  factory ContentRatings.fromJson(Map<String, dynamic> json) =>
      _$ContentRatingsFromJson(json);
  Map<String, dynamic> toJson() => _$ContentRatingsToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class Rating {
  String iso_3166_1;
  String rating;
  Rating(
    this.iso_3166_1,
    this.rating,
  );
  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  nullable: true,
)
class ExternalIds {
  String imdbId;
  String freebaseMid;
  String freebaseId;
  int tvdbId;
  int tvrageId;
  String facebookId;
  String instagramId;
  String twitterId;
  int id;
  ExternalIds(
    this.imdbId,
    this.freebaseMid,
    this.freebaseId,
    this.tvdbId,
    this.tvrageId,
    this.facebookId,
    this.instagramId,
    this.twitterId,
    this.id,
  );
  factory ExternalIds.fromJson(Map<String, dynamic> json) =>
      _$ExternalIdsFromJson(json);
  Map<String, dynamic> toJson() => _$ExternalIdsToJson(this);
}
