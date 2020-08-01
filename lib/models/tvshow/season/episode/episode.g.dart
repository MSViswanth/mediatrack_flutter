// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) {
  return Episode(
    json['air_date'] as String,
    (json['crew'] as List)
        ?.map(
            (e) => e == null ? null : Crew.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['episode_number'] as int,
    (json['guest_stars'] as List)
        ?.map(
            (e) => e == null ? null : Cast.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['name'] as String,
    json['overview'] as String,
    json['id'] as int,
    json['production_code'] as String,
    json['season_number'] as int,
    json['still_path'] as String,
    (json['vote_average'] as num)?.toDouble(),
    json['vote_count'] as int,
    json['credits'] == null
        ? null
        : Credits.fromJson(json['credits'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'air_date': instance.airDate,
      'crew': instance.crew,
      'episode_number': instance.episodeNumber,
      'guest_stars': instance.guestStars,
      'name': instance.name,
      'overview': instance.overview,
      'id': instance.id,
      'production_code': instance.productionCode,
      'season_number': instance.seasonNumber,
      'still_path': instance.stillPath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'credits': instance.credits,
    };
