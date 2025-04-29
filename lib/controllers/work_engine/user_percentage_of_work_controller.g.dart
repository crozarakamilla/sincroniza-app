// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_percentage_of_work_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userPercentageOfWorkControllerHash() =>
    r'a4fcfaa58d4e49cd350fd3af927c96dbf5b85798';

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

abstract class _$UserPercentageOfWorkController
    extends BuildlessAutoDisposeAsyncNotifier<Map<String, double>> {
  late final String userId;

  FutureOr<Map<String, double>> build(
    String userId,
  );
}

/// See also [UserPercentageOfWorkController].
@ProviderFor(UserPercentageOfWorkController)
const userPercentageOfWorkControllerProvider =
    UserPercentageOfWorkControllerFamily();

/// See also [UserPercentageOfWorkController].
class UserPercentageOfWorkControllerFamily
    extends Family<AsyncValue<Map<String, double>>> {
  /// See also [UserPercentageOfWorkController].
  const UserPercentageOfWorkControllerFamily();

  /// See also [UserPercentageOfWorkController].
  UserPercentageOfWorkControllerProvider call(
    String userId,
  ) {
    return UserPercentageOfWorkControllerProvider(
      userId,
    );
  }

  @override
  UserPercentageOfWorkControllerProvider getProviderOverride(
    covariant UserPercentageOfWorkControllerProvider provider,
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
  String? get name => r'userPercentageOfWorkControllerProvider';
}

/// See also [UserPercentageOfWorkController].
class UserPercentageOfWorkControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UserPercentageOfWorkController,
        Map<String, double>> {
  /// See also [UserPercentageOfWorkController].
  UserPercentageOfWorkControllerProvider(
    String userId,
  ) : this._internal(
          () => UserPercentageOfWorkController()..userId = userId,
          from: userPercentageOfWorkControllerProvider,
          name: r'userPercentageOfWorkControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userPercentageOfWorkControllerHash,
          dependencies: UserPercentageOfWorkControllerFamily._dependencies,
          allTransitiveDependencies:
              UserPercentageOfWorkControllerFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserPercentageOfWorkControllerProvider._internal(
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
  FutureOr<Map<String, double>> runNotifierBuild(
    covariant UserPercentageOfWorkController notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(UserPercentageOfWorkController Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserPercentageOfWorkControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<UserPercentageOfWorkController,
      Map<String, double>> createElement() {
    return _UserPercentageOfWorkControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserPercentageOfWorkControllerProvider &&
        other.userId == userId;
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
mixin UserPercentageOfWorkControllerRef
    on AutoDisposeAsyncNotifierProviderRef<Map<String, double>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserPercentageOfWorkControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        UserPercentageOfWorkController,
        Map<String, double>> with UserPercentageOfWorkControllerRef {
  _UserPercentageOfWorkControllerProviderElement(super.provider);

  @override
  String get userId =>
      (origin as UserPercentageOfWorkControllerProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
