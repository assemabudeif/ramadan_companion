// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adhkar_details_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoryAdhkarHash() => r'e1c54a62402ce182e74143b4c2c1f0b4eee839d0';

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

/// See also [categoryAdhkar].
@ProviderFor(categoryAdhkar)
const categoryAdhkarProvider = CategoryAdhkarFamily();

/// See also [categoryAdhkar].
class CategoryAdhkarFamily extends Family<AsyncValue<List<DhikrItem>>> {
  /// See also [categoryAdhkar].
  const CategoryAdhkarFamily();

  /// See also [categoryAdhkar].
  CategoryAdhkarProvider call(
    int categoryId,
  ) {
    return CategoryAdhkarProvider(
      categoryId,
    );
  }

  @override
  CategoryAdhkarProvider getProviderOverride(
    covariant CategoryAdhkarProvider provider,
  ) {
    return call(
      provider.categoryId,
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
  String? get name => r'categoryAdhkarProvider';
}

/// See also [categoryAdhkar].
class CategoryAdhkarProvider
    extends AutoDisposeFutureProvider<List<DhikrItem>> {
  /// See also [categoryAdhkar].
  CategoryAdhkarProvider(
    int categoryId,
  ) : this._internal(
          (ref) => categoryAdhkar(
            ref as CategoryAdhkarRef,
            categoryId,
          ),
          from: categoryAdhkarProvider,
          name: r'categoryAdhkarProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$categoryAdhkarHash,
          dependencies: CategoryAdhkarFamily._dependencies,
          allTransitiveDependencies:
              CategoryAdhkarFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  CategoryAdhkarProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int categoryId;

  @override
  Override overrideWith(
    FutureOr<List<DhikrItem>> Function(CategoryAdhkarRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CategoryAdhkarProvider._internal(
        (ref) => create(ref as CategoryAdhkarRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DhikrItem>> createElement() {
    return _CategoryAdhkarProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryAdhkarProvider && other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CategoryAdhkarRef on AutoDisposeFutureProviderRef<List<DhikrItem>> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;
}

class _CategoryAdhkarProviderElement
    extends AutoDisposeFutureProviderElement<List<DhikrItem>>
    with CategoryAdhkarRef {
  _CategoryAdhkarProviderElement(super.provider);

  @override
  int get categoryId => (origin as CategoryAdhkarProvider).categoryId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
