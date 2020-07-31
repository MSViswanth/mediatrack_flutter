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
            (e) => e == null ? null : Crew.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['name'] as String,
    json['overview'] as String,
    json['id'] as int,
    json['production_code'] as String,
    json['season_number'] as int,
    json['still_path'] as String,
    (json['vote_average'] as num)?.toDouble(),
    json['vote_count'] as int,
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
    };

Crew _$CrewFromJson(Map<String, dynamic> json) {
  return Crew(
    json['id'] as int,
    json['credit_id'] as String,
    json['name'] as String,
    json['department'] as String,
    json['job'] as String,
    json['profile_path'] as String,
  );
}

Map<String, dynamic> _$CrewToJson(Crew instance) => <String, dynamic>{
      'id': instance.id,
      'credit_id': instance.creditId,
      'name': instance.name,
      'department': instance.department,
      'job': instance.job,
      'profile_path': instance.profilePath,
    };
