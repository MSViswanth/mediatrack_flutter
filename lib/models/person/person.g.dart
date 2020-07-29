// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    json['birthday'] as String,
    json['known_for_department'] as String,
    json['deathday'] as String,
    json['id'] as int,
    json['name'] as String,
    (json['also_known_as'] as List)?.map((e) => e as String)?.toList(),
    json['gender'] as int,
    json['biography'] as String,
    (json['popularity'] as num)?.toDouble(),
    json['place_of_birth'] as String,
    json['profile_path'] as String,
    json['adult'] as bool,
    json['imdb_id'] as String,
    json['homepage'] as String,
    json['media_type'] as String,
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'birthday': instance.birthday,
      'known_for_department': instance.knownForDepartment,
      'deathday': instance.deathday,
      'id': instance.id,
      'name': instance.name,
      'also_known_as': instance.alsoKnownAs,
      'gender': instance.gender,
      'biography': instance.biography,
      'popularity': instance.popularity,
      'place_of_birth': instance.placeOfBirth,
      'profile_path': instance.profilePath,
      'adult': instance.adult,
      'imdb_id': instance.imdbId,
      'homepage': instance.homepage,
      'media_type': instance.mediaType,
    };
