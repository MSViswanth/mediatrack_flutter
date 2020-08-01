// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crew.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Crew _$CrewFromJson(Map<String, dynamic> json) {
  return Crew(
    json['id'] as int,
    json['credit_id'] as String,
    json['name'] as String,
    json['department'] as String,
    json['job'] as String,
    json['gender'] as int,
    json['profile_path'] as String,
  );
}

Map<String, dynamic> _$CrewToJson(Crew instance) => <String, dynamic>{
      'id': instance.id,
      'credit_id': instance.creditId,
      'name': instance.name,
      'department': instance.department,
      'job': instance.job,
      'gender': instance.gender,
      'profile_path': instance.profilePath,
    };
