// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_in_event_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$usersInEventControllerHash() =>
    r'548babb78bc7f3edda0774c72d8130c74d5b934a';

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

abstract class _$UsersInEventController
    extends BuildlessAutoDisposeAsyncNotifier<List<AppUser>> {
  late final String eventId;

  FutureOr<List<AppUser>> build(
    String eventId,
  );
}

/// See also [UsersInEventController].
@ProviderFor(UsersInEventController)
const usersInEventControllerProvider = UsersInEventControllerFamily();

/// See also [UsersInEventController].
class UsersInEventControllerFamily extends Family<AsyncValue<List<AppUser>>> {
  /// See also [UsersInEventController].
  const UsersInEventControllerFamily();

  /// See also [UsersInEventController].
  UsersInEventControllerProvider call(
    String eventId,
  ) {
    return UsersInEventControllerProvider(
      eventId,
    );
  }

  @override
  UsersInEventControllerProvider getProviderOverride(
    covariant UsersInEventControllerProvider provider,
  ) {
    return call(
      provider.eventId,
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
  String? get name => r'usersInEventControllerProvider';
}

/// See also [UsersInEventController].
class UsersInEventControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UsersInEventController,
        List<AppUser>> {
  /// See also [UsersInEventController].
  UsersInEventControllerProvider(
    String eventId,
  ) : this._internal(
          () => UsersInEventController()..eventId = eventId,
          from: usersInEventControllerProvider,
          name: r'usersInEventControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$usersInEventControllerHash,
          dependencies: UsersInEventControllerFamily._dependencies,
          allTransitiveDependencies:
              UsersInEventControllerFamily._allTransitiveDependencies,
          eventId: eventId,
        );

  UsersInEventControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
  }) : super.internal();

  final String eventId;

  @override
  FutureOr<List<AppUser>> runNotifierBuild(
    covariant UsersInEventController notifier,
  ) {
    return notifier.build(
      eventId,
    );
  }

  @override
  Override overrideWith(UsersInEventController Function() create) {
    return ProviderOverride(
      origin: this,
      override: UsersInEventControllerProvider._internal(
        () => create()..eventId = eventId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<UsersInEventController, List<AppUser>>
      createElement() {
    return _UsersInEventControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UsersInEventControllerProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UsersInEventControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<AppUser>> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _UsersInEventControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UsersInEventController,
        List<AppUser>> with UsersInEventControllerRef {
  _UsersInEventControllerProviderElement(super.provider);

  @override
  String get eventId => (origin as UsersInEventControllerProvider).eventId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
