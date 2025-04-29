// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  String? get id => throw _privateConstructorUsedError;
  set id(String? value) => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  set title(String? value) => throw _privateConstructorUsedError;
  String? get eventDay => throw _privateConstructorUsedError;
  set eventDay(String? value) => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _fromTimestamp, toJson: _toTimestamp)
  DateTime? get eventDate => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _fromTimestamp, toJson: _toTimestamp)
  set eventDate(DateTime? value) => throw _privateConstructorUsedError;
  String? get startTime => throw _privateConstructorUsedError;
  set startTime(String? value) => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  set location(String? value) => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  set category(String? value) => throw _privateConstructorUsedError;
  String? get groupId => throw _privateConstructorUsedError;
  set groupId(String? value) => throw _privateConstructorUsedError;
  String? get rehearsalsQuantity => throw _privateConstructorUsedError;
  set rehearsalsQuantity(String? value) => throw _privateConstructorUsedError;
  List<String>? get eventDetails => throw _privateConstructorUsedError;
  set eventDetails(List<String>? value) => throw _privateConstructorUsedError;
  String? get conductor => throw _privateConstructorUsedError;
  set conductor(String? value) => throw _privateConstructorUsedError;
  String? get soloist => throw _privateConstructorUsedError;
  set soloist(String? value) => throw _privateConstructorUsedError;
  List<String>? get participants => throw _privateConstructorUsedError;
  set participants(List<String>? value) => throw _privateConstructorUsedError;

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call(
      {String? id,
      String? title,
      String? eventDay,
      @JsonKey(fromJson: _fromTimestamp, toJson: _toTimestamp)
      DateTime? eventDate,
      String? startTime,
      String? location,
      String? category,
      String? groupId,
      String? rehearsalsQuantity,
      List<String>? eventDetails,
      String? conductor,
      String? soloist,
      List<String>? participants});
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? eventDay = freezed,
    Object? eventDate = freezed,
    Object? startTime = freezed,
    Object? location = freezed,
    Object? category = freezed,
    Object? groupId = freezed,
    Object? rehearsalsQuantity = freezed,
    Object? eventDetails = freezed,
    Object? conductor = freezed,
    Object? soloist = freezed,
    Object? participants = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      eventDay: freezed == eventDay
          ? _value.eventDay
          : eventDay // ignore: cast_nullable_to_non_nullable
              as String?,
      eventDate: freezed == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      rehearsalsQuantity: freezed == rehearsalsQuantity
          ? _value.rehearsalsQuantity
          : rehearsalsQuantity // ignore: cast_nullable_to_non_nullable
              as String?,
      eventDetails: freezed == eventDetails
          ? _value.eventDetails
          : eventDetails // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      conductor: freezed == conductor
          ? _value.conductor
          : conductor // ignore: cast_nullable_to_non_nullable
              as String?,
      soloist: freezed == soloist
          ? _value.soloist
          : soloist // ignore: cast_nullable_to_non_nullable
              as String?,
      participants: freezed == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventImplCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$EventImplCopyWith(
          _$EventImpl value, $Res Function(_$EventImpl) then) =
      __$$EventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? title,
      String? eventDay,
      @JsonKey(fromJson: _fromTimestamp, toJson: _toTimestamp)
      DateTime? eventDate,
      String? startTime,
      String? location,
      String? category,
      String? groupId,
      String? rehearsalsQuantity,
      List<String>? eventDetails,
      String? conductor,
      String? soloist,
      List<String>? participants});
}

/// @nodoc
class __$$EventImplCopyWithImpl<$Res>
    extends _$EventCopyWithImpl<$Res, _$EventImpl>
    implements _$$EventImplCopyWith<$Res> {
  __$$EventImplCopyWithImpl(
      _$EventImpl _value, $Res Function(_$EventImpl) _then)
      : super(_value, _then);

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? eventDay = freezed,
    Object? eventDate = freezed,
    Object? startTime = freezed,
    Object? location = freezed,
    Object? category = freezed,
    Object? groupId = freezed,
    Object? rehearsalsQuantity = freezed,
    Object? eventDetails = freezed,
    Object? conductor = freezed,
    Object? soloist = freezed,
    Object? participants = freezed,
  }) {
    return _then(_$EventImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      eventDay: freezed == eventDay
          ? _value.eventDay
          : eventDay // ignore: cast_nullable_to_non_nullable
              as String?,
      eventDate: freezed == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      rehearsalsQuantity: freezed == rehearsalsQuantity
          ? _value.rehearsalsQuantity
          : rehearsalsQuantity // ignore: cast_nullable_to_non_nullable
              as String?,
      eventDetails: freezed == eventDetails
          ? _value.eventDetails
          : eventDetails // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      conductor: freezed == conductor
          ? _value.conductor
          : conductor // ignore: cast_nullable_to_non_nullable
              as String?,
      soloist: freezed == soloist
          ? _value.soloist
          : soloist // ignore: cast_nullable_to_non_nullable
              as String?,
      participants: freezed == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventImpl extends _Event {
  _$EventImpl(
      {this.id,
      this.title,
      this.eventDay,
      @JsonKey(fromJson: _fromTimestamp, toJson: _toTimestamp) this.eventDate,
      this.startTime,
      this.location,
      this.category,
      this.groupId,
      this.rehearsalsQuantity,
      this.eventDetails,
      this.conductor,
      this.soloist,
      this.participants})
      : super._();

  factory _$EventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventImplFromJson(json);

  @override
  String? id;
  @override
  String? title;
  @override
  String? eventDay;
  @override
  @JsonKey(fromJson: _fromTimestamp, toJson: _toTimestamp)
  DateTime? eventDate;
  @override
  String? startTime;
  @override
  String? location;
  @override
  String? category;
  @override
  String? groupId;
  @override
  String? rehearsalsQuantity;
  @override
  List<String>? eventDetails;
  @override
  String? conductor;
  @override
  String? soloist;
  @override
  List<String>? participants;

  @override
  String toString() {
    return 'Event(id: $id, title: $title, eventDay: $eventDay, eventDate: $eventDate, startTime: $startTime, location: $location, category: $category, groupId: $groupId, rehearsalsQuantity: $rehearsalsQuantity, eventDetails: $eventDetails, conductor: $conductor, soloist: $soloist, participants: $participants)';
  }

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      __$$EventImplCopyWithImpl<_$EventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventImplToJson(
      this,
    );
  }
}

abstract class _Event extends Event {
  factory _Event(
      {String? id,
      String? title,
      String? eventDay,
      @JsonKey(fromJson: _fromTimestamp, toJson: _toTimestamp)
      DateTime? eventDate,
      String? startTime,
      String? location,
      String? category,
      String? groupId,
      String? rehearsalsQuantity,
      List<String>? eventDetails,
      String? conductor,
      String? soloist,
      List<String>? participants}) = _$EventImpl;
  _Event._() : super._();

  factory _Event.fromJson(Map<String, dynamic> json) = _$EventImpl.fromJson;

  @override
  String? get id;
  set id(String? value);
  @override
  String? get title;
  set title(String? value);
  @override
  String? get eventDay;
  set eventDay(String? value);
  @override
  @JsonKey(fromJson: _fromTimestamp, toJson: _toTimestamp)
  DateTime? get eventDate;
  @JsonKey(fromJson: _fromTimestamp, toJson: _toTimestamp)
  set eventDate(DateTime? value);
  @override
  String? get startTime;
  set startTime(String? value);
  @override
  String? get location;
  set location(String? value);
  @override
  String? get category;
  set category(String? value);
  @override
  String? get groupId;
  set groupId(String? value);
  @override
  String? get rehearsalsQuantity;
  set rehearsalsQuantity(String? value);
  @override
  List<String>? get eventDetails;
  set eventDetails(List<String>? value);
  @override
  String? get conductor;
  set conductor(String? value);
  @override
  String? get soloist;
  set soloist(String? value);
  @override
  List<String>? get participants;
  set participants(List<String>? value);

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
