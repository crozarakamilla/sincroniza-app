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
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  DateTime get eventDay => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  List<String>? get eventDetails => throw _privateConstructorUsedError;
  String? get conductor => throw _privateConstructorUsedError;
  String? get soloist => throw _privateConstructorUsedError;
  List<String>? get participants => throw _privateConstructorUsedError;

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
      {String id,
      String title,
      DateTime startDate,
      DateTime endDate,
      DateTime eventDay,
      DateTime startTime,
      String location,
      String category,
      String groupId,
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
    Object? id = null,
    Object? title = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? eventDay = null,
    Object? startTime = null,
    Object? location = null,
    Object? category = null,
    Object? groupId = null,
    Object? eventDetails = freezed,
    Object? conductor = freezed,
    Object? soloist = freezed,
    Object? participants = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eventDay: null == eventDay
          ? _value.eventDay
          : eventDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
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
      {String id,
      String title,
      DateTime startDate,
      DateTime endDate,
      DateTime eventDay,
      DateTime startTime,
      String location,
      String category,
      String groupId,
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
    Object? id = null,
    Object? title = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? eventDay = null,
    Object? startTime = null,
    Object? location = null,
    Object? category = null,
    Object? groupId = null,
    Object? eventDetails = freezed,
    Object? conductor = freezed,
    Object? soloist = freezed,
    Object? participants = freezed,
  }) {
    return _then(_$EventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eventDay: null == eventDay
          ? _value.eventDay
          : eventDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      eventDetails: freezed == eventDetails
          ? _value._eventDetails
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
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventImpl extends _Event {
  _$EventImpl(
      {required this.id,
      required this.title,
      required this.startDate,
      required this.endDate,
      required this.eventDay,
      required this.startTime,
      required this.location,
      required this.category,
      required this.groupId,
      final List<String>? eventDetails,
      this.conductor,
      this.soloist,
      final List<String>? participants})
      : _eventDetails = eventDetails,
        _participants = participants,
        super._();

  factory _$EventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final DateTime eventDay;
  @override
  final DateTime startTime;
  @override
  final String location;
  @override
  final String category;
  @override
  final String groupId;
  final List<String>? _eventDetails;
  @override
  List<String>? get eventDetails {
    final value = _eventDetails;
    if (value == null) return null;
    if (_eventDetails is EqualUnmodifiableListView) return _eventDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? conductor;
  @override
  final String? soloist;
  final List<String>? _participants;
  @override
  List<String>? get participants {
    final value = _participants;
    if (value == null) return null;
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Event(id: $id, title: $title, startDate: $startDate, endDate: $endDate, eventDay: $eventDay, startTime: $startTime, location: $location, category: $category, groupId: $groupId, eventDetails: $eventDetails, conductor: $conductor, soloist: $soloist, participants: $participants)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.eventDay, eventDay) ||
                other.eventDay == eventDay) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            const DeepCollectionEquality()
                .equals(other._eventDetails, _eventDetails) &&
            (identical(other.conductor, conductor) ||
                other.conductor == conductor) &&
            (identical(other.soloist, soloist) || other.soloist == soloist) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      startDate,
      endDate,
      eventDay,
      startTime,
      location,
      category,
      groupId,
      const DeepCollectionEquality().hash(_eventDetails),
      conductor,
      soloist,
      const DeepCollectionEquality().hash(_participants));

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
      {required final String id,
      required final String title,
      required final DateTime startDate,
      required final DateTime endDate,
      required final DateTime eventDay,
      required final DateTime startTime,
      required final String location,
      required final String category,
      required final String groupId,
      final List<String>? eventDetails,
      final String? conductor,
      final String? soloist,
      final List<String>? participants}) = _$EventImpl;
  _Event._() : super._();

  factory _Event.fromJson(Map<String, dynamic> json) = _$EventImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  DateTime get eventDay;
  @override
  DateTime get startTime;
  @override
  String get location;
  @override
  String get category;
  @override
  String get groupId;
  @override
  List<String>? get eventDetails;
  @override
  String? get conductor;
  @override
  String? get soloist;
  @override
  List<String>? get participants;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
