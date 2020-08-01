// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Season _$SeasonFromJson(Map<String, dynamic> json) {
  return Season(
    json['_id'] as String,
    json['air_date'] as String,
    (json['episodes'] as List)
        ?.map((e) =>
            e == null ? null : Episode.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['name'] as String,
    json['overview'] as String,
    json['id'] as int,
    json['poster_path'] as String,
    json['season_number'] as int,
    json['credits'] == null
        ? null
        : Credits.fromJson(json['credits'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      '_id': instance.sId,
      'air_date': instance.airDate,
      'episodes': instance.episodes?.map((e) => e?.toJson())?.toList(),
      'name': instance.name,
      'overview': instance.overview,
      'id': instance.id,
      'poster_path': instance.posterPath,
      'season_number': instance.seasonNumber,
      'credits': instance.credits?.toJson(),
    };
