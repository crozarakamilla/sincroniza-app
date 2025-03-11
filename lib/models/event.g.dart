// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
      id: json['id'] as String?,
      title: json['title'] as String?,
      eventDay: json['eventDay'] as String?,
      startTime: json['startTime'] as String?,
      location: json['location'] as String?,
      category: json['category'] as String?,
      groupId: json['groupId'] as String?,
      rehearsalsQuantity: json['rehearsalsQuantity'] as String?,
      eventDetails: (json['eventDetails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      conductor: json['conductor'] as String?,
      soloist: json['soloist'] as String?,
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'eventDay': instance.eventDay,
      'startTime': instance.startTime,
      'location': instance.location,
      'category': instance.category,
      'groupId': instance.groupId,
      'rehearsalsQuantity': instance.rehearsalsQuantity,
      'eventDetails': instance.eventDetails,
      'conductor': instance.conductor,
      'soloist': instance.soloist,
      'participants': instance.participants,
    };
