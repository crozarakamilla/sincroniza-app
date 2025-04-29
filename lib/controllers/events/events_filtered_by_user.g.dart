// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_filtered_by_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventsFilteredByUserHash() =>
    r'82a05c59f9f57c04f6e1ee4d4741764fe1ea70bd';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$EventsFilteredByUser
    extends BuildlessAutoDisposeAsyncNotifier<List<Event>> {
  late final String userId;

  FutureOr<List<Event>> build(
    String userId,
  );
}

/// See also [EventsFilteredByUser].
@ProviderFor(EventsFilteredByUser)
const eventsFilteredByUserProvider = EventsFilteredByUserFamily();

/// See also [EventsFilteredByUser].
class EventsFilteredByUserFamily extends Family<AsyncValue<List<Event>>> {
  /// See also [EventsFilteredByUser].
  const EventsFilteredByUserFamily();

  /// See also [EventsFilteredByUser].
  EventsFilteredByUserProvider call(
    String userId,
  ) {
    return EventsFilteredByUserProvider(
      userId,
    );
  }

  @override
  EventsFilteredByUserProvider getProviderOverride(
    covariant EventsFilteredByUserProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'eventsFilteredByUserProvider';
}

/// See also [EventsFilteredByUser].
class EventsFilteredByUserProvider extends AutoDisposeAsyncNotifierProviderImpl<
    EventsFilteredByUser, List<Event>> {
  /// See also [EventsFilteredByUser].
  EventsFilteredByUserProvider(
    String userId,
  ) : this._internal(
          () => EventsFilteredByUser()..userId = userId,
          from: eventsFilteredByUserProvider,
          name: r'eventsFilteredByUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventsFilteredByUserHash,
          dependencies: EventsFilteredByUserFamily._dependencies,
          allTransitiveDependencies:
              EventsFilteredByUserFamily._allTransitiveDependencies,
          userId: userId,
        );

  EventsFilteredByUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  FutureOr<List<Event>> runNotifierBuild(
    covariant EventsFilteredByUser notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(EventsFilteredByUser Function() create) {
    return ProviderOverride(
      origin: this,
      override: EventsFilteredByUserProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<EventsFilteredByUser, List<Event>>
      createElement() {
    return _EventsFilteredByUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventsFilteredByUserProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EventsFilteredByUserRef
    on AutoDisposeAsyncNotifierProviderRef<List<Event>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _EventsFilteredByUserProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<EventsFilteredByUser,
        List<Event>> with EventsFilteredByUserRef {
  _EventsFilteredByUserProviderElement(super.provider);

  @override
  String get userId => (origin as EventsFilteredByUserProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
