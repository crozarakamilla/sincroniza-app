// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_in_group_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$usersInGroupControllerHash() =>
    r'a2167231f26e2aa5daacc7e112d61a55161ef474';

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

abstract class _$UsersInGroupController
    extends BuildlessAutoDisposeAsyncNotifier<List<AppUser>> {
  late final String groupId;

  FutureOr<List<AppUser>> build(
    String groupId,
  );
}

/// See also [UsersInGroupController].
@ProviderFor(UsersInGroupController)
const usersInGroupControllerProvider = UsersInGroupControllerFamily();

/// See also [UsersInGroupController].
class UsersInGroupControllerFamily extends Family<AsyncValue<List<AppUser>>> {
  /// See also [UsersInGroupController].
  const UsersInGroupControllerFamily();

  /// See also [UsersInGroupController].
  UsersInGroupControllerProvider call(
    String groupId,
  ) {
    return UsersInGroupControllerProvider(
      groupId,
    );
  }

  @override
  UsersInGroupControllerProvider getProviderOverride(
    covariant UsersInGroupControllerProvider provider,
  ) {
    return call(
      provider.groupId,
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
  String? get name => r'usersInGroupControllerProvider';
}

/// See also [UsersInGroupController].
class UsersInGroupControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UsersInGroupController,
        List<AppUser>> {
  /// See also [UsersInGroupController].
  UsersInGroupControllerProvider(
    String groupId,
  ) : this._internal(
          () => UsersInGroupController()..groupId = groupId,
          from: usersInGroupControllerProvider,
          name: r'usersInGroupControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$usersInGroupControllerHash,
          dependencies: UsersInGroupControllerFamily._dependencies,
          allTransitiveDependencies:
              UsersInGroupControllerFamily._allTransitiveDependencies,
          groupId: groupId,
        );

  UsersInGroupControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupId,
  }) : super.internal();

  final String groupId;

  @override
  FutureOr<List<AppUser>> runNotifierBuild(
    covariant UsersInGroupController notifier,
  ) {
    return notifier.build(
      groupId,
    );
  }

  @override
  Override overrideWith(UsersInGroupController Function() create) {
    return ProviderOverride(
      origin: this,
      override: UsersInGroupControllerProvider._internal(
        () => create()..groupId = groupId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupId: groupId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<UsersInGroupController, List<AppUser>>
      createElement() {
    return _UsersInGroupControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UsersInGroupControllerProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UsersInGroupControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<AppUser>> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _UsersInGroupControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UsersInGroupController,
        List<AppUser>> with UsersInGroupControllerRef {
  _UsersInGroupControllerProviderElement(super.provider);

  @override
  String get groupId => (origin as UsersInGroupControllerProvider).groupId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
