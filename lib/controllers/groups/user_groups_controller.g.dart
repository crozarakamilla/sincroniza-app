// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_groups_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userGroupsControllerHash() =>
    r'80f4462ee408fec000e4bf97d0b681b911d6884a';

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

abstract class _$UserGroupsController
    extends BuildlessAutoDisposeAsyncNotifier<List<Group>> {
  late final String userId;

  FutureOr<List<Group>> build(
    String userId,
  );
}

/// See also [UserGroupsController].
@ProviderFor(UserGroupsController)
const userGroupsControllerProvider = UserGroupsControllerFamily();

/// See also [UserGroupsController].
class UserGroupsControllerFamily extends Family<AsyncValue<List<Group>>> {
  /// See also [UserGroupsController].
  const UserGroupsControllerFamily();

  /// See also [UserGroupsController].
  UserGroupsControllerProvider call(
    String userId,
  ) {
    return UserGroupsControllerProvider(
      userId,
    );
  }

  @override
  UserGroupsControllerProvider getProviderOverride(
    covariant UserGroupsControllerProvider provider,
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
  String? get name => r'userGroupsControllerProvider';
}

/// See also [UserGroupsController].
class UserGroupsControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    UserGroupsController, List<Group>> {
  /// See also [UserGroupsController].
  UserGroupsControllerProvider(
    String userId,
  ) : this._internal(
          () => UserGroupsController()..userId = userId,
          from: userGroupsControllerProvider,
          name: r'userGroupsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userGroupsControllerHash,
          dependencies: UserGroupsControllerFamily._dependencies,
          allTransitiveDependencies:
              UserGroupsControllerFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserGroupsControllerProvider._internal(
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
  FutureOr<List<Group>> runNotifierBuild(
    covariant UserGroupsController notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(UserGroupsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserGroupsControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<UserGroupsController, List<Group>>
      createElement() {
    return _UserGroupsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserGroupsControllerProvider && other.userId == userId;
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
mixin UserGroupsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<Group>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserGroupsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserGroupsController,
        List<Group>> with UserGroupsControllerRef {
  _UserGroupsControllerProviderElement(super.provider);

  @override
  String get userId => (origin as UserGroupsControllerProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
