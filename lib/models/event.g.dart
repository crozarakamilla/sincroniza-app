// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      eventDay: DateTime.parse(json['eventDay'] as String),
      startTime: DateTime.parse(json['startTime'] as String),
      location: json['location'] as String,
      category: json['category'] as String,
      eventDetails: (json['eventDetails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      conductor: json['conductor'] as String?,
      soloist: json['soloist'] as String?,
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => AppUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'eventDay': instance.eventDay.toIso8601String(),
      'startTime': instance.startTime.toIso8601String(),
      'location': instance.location,
      'category': instance.category,
      'eventDetails': instance.eventDetails,
      'conductor': instance.conductor,
      'soloist': instance.soloist,
      'participants': instance.participants,
    };
