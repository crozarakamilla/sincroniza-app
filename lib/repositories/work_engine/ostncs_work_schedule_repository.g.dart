// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ostncs_work_schedule_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ostncsScheduleRepositoryHash() =>
    r'cd85eee1eeb6cf4f216382757fdeb000159474f7';

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

/// See also [ostncsScheduleRepository].
@ProviderFor(ostncsScheduleRepository)
const ostncsScheduleRepositoryProvider = OstncsScheduleRepositoryFamily();

/// See also [ostncsScheduleRepository].
class OstncsScheduleRepositoryFamily
    extends Family<OstncsWorkScheduleRepository> {
  /// See also [ostncsScheduleRepository].
  const OstncsScheduleRepositoryFamily();

  /// See also [ostncsScheduleRepository].
  OstncsScheduleRepositoryProvider call(
    String userId,
  ) {
    return OstncsScheduleRepositoryProvider(
      userId,
    );
  }

  @override
  OstncsScheduleRepositoryProvider getProviderOverride(
    covariant OstncsScheduleRepositoryProvider provider,
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
  String? get name => r'ostncsScheduleRepositoryProvider';
}

/// See also [ostncsScheduleRepository].
class OstncsScheduleRepositoryProvider
    extends AutoDisposeProvider<OstncsWorkScheduleRepository> {
  /// See also [ostncsScheduleRepository].
  OstncsScheduleRepositoryProvider(
    String userId,
  ) : this._internal(
          (ref) => ostncsScheduleRepository(
            ref as OstncsScheduleRepositoryRef,
            userId,
          ),
          from: ostncsScheduleRepositoryProvider,
          name: r'ostncsScheduleRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ostncsScheduleRepositoryHash,
          dependencies: OstncsScheduleRepositoryFamily._dependencies,
          allTransitiveDependencies:
              OstncsScheduleRepositoryFamily._allTransitiveDependencies,
          userId: userId,
        );

  OstncsScheduleRepositoryProvider._internal(
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
  Override overrideWith(
    OstncsWorkScheduleRepository Function(OstncsScheduleRepositoryRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OstncsScheduleRepositoryProvider._internal(
        (ref) => create(ref as OstncsScheduleRepositoryRef),
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
  AutoDisposeProviderElement<OstncsWorkScheduleRepository> createElement() {
    return _OstncsScheduleRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OstncsScheduleRepositoryProvider && other.userId == userId;
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
mixin OstncsScheduleRepositoryRef
    on AutoDisposeProviderRef<OstncsWorkScheduleRepository> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _OstncsScheduleRepositoryProviderElement
    extends AutoDisposeProviderElement<OstncsWorkScheduleRepository>
    with OstncsScheduleRepositoryRef {
  _OstncsScheduleRepositoryProviderElement(super.provider);

  @override
  String get userId => (origin as OstncsScheduleRepositoryProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
