// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupImpl _$$GroupImplFromJson(Map<String, dynamic> json) => _$GroupImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      users: (json['users'] as List<dynamic>).map((e) => e as String).toList(),
      groupAdmins: json['groupAdmins'] as List<dynamic>,
      events: json['events'] as List<dynamic>?,
      instruments: json['instruments'] as bool,
    );

Map<String, dynamic> _$$GroupImplToJson(_$GroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'users': instance.users,
      'groupAdmins': instance.groupAdmins,
      'events': instance.events,
      'instruments': instance.instruments,
    };
