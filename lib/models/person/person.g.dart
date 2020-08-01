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
    (json['movie_credits'] as List)
        ?.map((e) => e == null
            ? null
            : PersonCreditMovies.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['tv_credits'] as List)
        ?.map((e) => e == null
            ? null
            : PersonCreditTVShows.fromJson(e as Map<String, dynamic>))
        ?.toList(),
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
      'movie_credits': instance.movieCredits?.map((e) => e?.toJson())?.toList(),
      'tv_credits': instance.tvCredits?.map((e) => e?.toJson())?.toList(),
    };

PersonCreditMovies _$PersonCreditMoviesFromJson(Map<String, dynamic> json) {
  return PersonCreditMovies(
    (json['cast'] as List)
        ?.map(
            (e) => e == null ? null : Movie.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['crew'] as List)
        ?.map(
            (e) => e == null ? null : Movie.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['id'] as int,
  );
}

Map<String, dynamic> _$PersonCreditMoviesToJson(PersonCreditMovies instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cast': instance.cast?.map((e) => e?.toJson())?.toList(),
      'crew': instance.crew?.map((e) => e?.toJson())?.toList(),
    };

PersonCreditTVShows _$PersonCreditTVShowsFromJson(Map<String, dynamic> json) {
  return PersonCreditTVShows(
    (json['cast'] as List)
        ?.map((e) =>
            e == null ? null : TVShow.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['crew'] as List)
        ?.map((e) =>
            e == null ? null : TVShow.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['id'] as int,
  );
}

Map<String, dynamic> _$PersonCreditTVShowsToJson(
        PersonCreditTVShows instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cast': instance.cast?.map((e) => e?.toJson())?.toList(),
      'crew': instance.crew?.map((e) => e?.toJson())?.toList(),
    };
