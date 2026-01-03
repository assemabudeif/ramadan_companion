// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_page_view_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quranPageHash() => r'9e63b890a3cf75cae21cde2c9c181cca936298e2';

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

/// See also [quranPage].
@ProviderFor(quranPage)
const quranPageProvider = QuranPageFamily();

/// See also [quranPage].
class QuranPageFamily extends Family<AsyncValue<List<QuranAyah>>> {
  /// See also [quranPage].
  const QuranPageFamily();

  /// See also [quranPage].
  QuranPageProvider call(
    int pageNumber,
  ) {
    return QuranPageProvider(
      pageNumber,
    );
  }

  @override
  QuranPageProvider getProviderOverride(
    covariant QuranPageProvider provider,
  ) {
    return call(
      provider.pageNumber,
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
  String? get name => r'quranPageProvider';
}

/// See also [quranPage].
class QuranPageProvider extends AutoDisposeFutureProvider<List<QuranAyah>> {
  /// See also [quranPage].
  QuranPageProvider(
    int pageNumber,
  ) : this._internal(
          (ref) => quranPage(
            ref as QuranPageRef,
            pageNumber,
          ),
          from: quranPageProvider,
          name: r'quranPageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$quranPageHash,
          dependencies: QuranPageFamily._dependencies,
          allTransitiveDependencies: QuranPageFamily._allTransitiveDependencies,
          pageNumber: pageNumber,
        );

  QuranPageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pageNumber,
  }) : super.internal();

  final int pageNumber;

  @override
  Override overrideWith(
    FutureOr<List<QuranAyah>> Function(QuranPageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: QuranPageProvider._internal(
        (ref) => create(ref as QuranPageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pageNumber: pageNumber,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<QuranAyah>> createElement() {
    return _QuranPageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuranPageProvider && other.pageNumber == pageNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pageNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin QuranPageRef on AutoDisposeFutureProviderRef<List<QuranAyah>> {
  /// The parameter `pageNumber` of this provider.
  int get pageNumber;
}

class _QuranPageProviderElement
    extends AutoDisposeFutureProviderElement<List<QuranAyah>>
    with QuranPageRef {
  _QuranPageProviderElement(super.provider);

  @override
  int get pageNumber => (origin as QuranPageProvider).pageNumber;
}

String _$tafseerHash() => r'7182b35a716d0ca3cbd04714d1eb123b24d56997';

/// See also [tafseer].
@ProviderFor(tafseer)
const tafseerProvider = TafseerFamily();

/// See also [tafseer].
class TafseerFamily extends Family<AsyncValue<QuranTafseer?>> {
  /// See also [tafseer].
  const TafseerFamily();

  /// See also [tafseer].
  TafseerProvider call(
    int surah,
    int ayah,
  ) {
    return TafseerProvider(
      surah,
      ayah,
    );
  }

  @override
  TafseerProvider getProviderOverride(
    covariant TafseerProvider provider,
  ) {
    return call(
      provider.surah,
      provider.ayah,
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
  String? get name => r'tafseerProvider';
}

/// See also [tafseer].
class TafseerProvider extends AutoDisposeFutureProvider<QuranTafseer?> {
  /// See also [tafseer].
  TafseerProvider(
    int surah,
    int ayah,
  ) : this._internal(
          (ref) => tafseer(
            ref as TafseerRef,
            surah,
            ayah,
          ),
          from: tafseerProvider,
          name: r'tafseerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tafseerHash,
          dependencies: TafseerFamily._dependencies,
          allTransitiveDependencies: TafseerFamily._allTransitiveDependencies,
          surah: surah,
          ayah: ayah,
        );

  TafseerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.surah,
    required this.ayah,
  }) : super.internal();

  final int surah;
  final int ayah;

  @override
  Override overrideWith(
    FutureOr<QuranTafseer?> Function(TafseerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TafseerProvider._internal(
        (ref) => create(ref as TafseerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        surah: surah,
        ayah: ayah,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<QuranTafseer?> createElement() {
    return _TafseerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TafseerProvider &&
        other.surah == surah &&
        other.ayah == ayah;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surah.hashCode);
    hash = _SystemHash.combine(hash, ayah.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TafseerRef on AutoDisposeFutureProviderRef<QuranTafseer?> {
  /// The parameter `surah` of this provider.
  int get surah;

  /// The parameter `ayah` of this provider.
  int get ayah;
}

class _TafseerProviderElement
    extends AutoDisposeFutureProviderElement<QuranTafseer?> with TafseerRef {
  _TafseerProviderElement(super.provider);

  @override
  int get surah => (origin as TafseerProvider).surah;
  @override
  int get ayah => (origin as TafseerProvider).ayah;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
