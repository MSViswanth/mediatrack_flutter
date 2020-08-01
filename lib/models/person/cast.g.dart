// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cast _$CastFromJson(Map<String, dynamic> json) {
  return Cast(
    json['id'] as int,
    json['credit_id'] as String,
    json['name'] as String,
    json['character'] as String,
    json['order'] as int,
    json['gender'] as int,
    json['profile_path'] as String,
  );
}

Map<String, dynamic> _$CastToJson(Cast instance) => <String, dynamic>{
      'id': instance.id,
      'credit_id': instance.creditId,
      'name': instance.name,
      'character': instance.character,
      'order': instance.order,
      'gender': instance.gender,
      'profile_path': instance.profilePath,
    };
