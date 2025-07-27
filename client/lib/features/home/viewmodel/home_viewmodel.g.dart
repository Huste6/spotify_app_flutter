// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getRecentlyPlayedSongsHash() =>
    r'd6fbdd56bc64750cd145c5f7ff225b4b73158b5b';

/// See also [getRecentlyPlayedSongs].
@ProviderFor(getRecentlyPlayedSongs)
final getRecentlyPlayedSongsProvider =
    AutoDisposeProvider<List<SongModel>>.internal(
  getRecentlyPlayedSongs,
  name: r'getRecentlyPlayedSongsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getRecentlyPlayedSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetRecentlyPlayedSongsRef = AutoDisposeProviderRef<List<SongModel>>;
String _$getAllSongsHash() => r'a06f06bef1b9213d7a6fb1458e5a4d32f0c45f7e';

/// See also [getAllSongs].
@ProviderFor(getAllSongs)
final getAllSongsProvider = AutoDisposeFutureProvider<List<SongModel>>.internal(
  getAllSongs,
  name: r'getAllSongsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getAllSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetAllSongsRef = AutoDisposeFutureProviderRef<List<SongModel>>;
String _$getFavSongsHash() => r'e8267400e08aed8c5234bf99edd733d05dec514b';

/// See also [getFavSongs].
@ProviderFor(getFavSongs)
final getFavSongsProvider = AutoDisposeFutureProvider<List<SongModel>>.internal(
  getFavSongs,
  name: r'getFavSongsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getFavSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetFavSongsRef = AutoDisposeFutureProviderRef<List<SongModel>>;
String _$getSearchSongsHash() => r'd6e0f261d9d8288ddf74ce21e8edfeabfeeeaeba';

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

/// See also [getSearchSongs].
@ProviderFor(getSearchSongs)
const getSearchSongsProvider = GetSearchSongsFamily();

/// See also [getSearchSongs].
class GetSearchSongsFamily extends Family<AsyncValue<List<SongModel>>> {
  /// See also [getSearchSongs].
  const GetSearchSongsFamily();

  /// See also [getSearchSongs].
  GetSearchSongsProvider call(
    String searchQuery,
  ) {
    return GetSearchSongsProvider(
      searchQuery,
    );
  }

  @override
  GetSearchSongsProvider getProviderOverride(
    covariant GetSearchSongsProvider provider,
  ) {
    return call(
      provider.searchQuery,
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
  String? get name => r'getSearchSongsProvider';
}

/// See also [getSearchSongs].
class GetSearchSongsProvider
    extends AutoDisposeFutureProvider<List<SongModel>> {
  /// See also [getSearchSongs].
  GetSearchSongsProvider(
    String searchQuery,
  ) : this._internal(
          (ref) => getSearchSongs(
            ref as GetSearchSongsRef,
            searchQuery,
          ),
          from: getSearchSongsProvider,
          name: r'getSearchSongsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSearchSongsHash,
          dependencies: GetSearchSongsFamily._dependencies,
          allTransitiveDependencies:
              GetSearchSongsFamily._allTransitiveDependencies,
          searchQuery: searchQuery,
        );

  GetSearchSongsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.searchQuery,
  }) : super.internal();

  final String searchQuery;

  @override
  Override overrideWith(
    FutureOr<List<SongModel>> Function(GetSearchSongsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSearchSongsProvider._internal(
        (ref) => create(ref as GetSearchSongsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        searchQuery: searchQuery,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SongModel>> createElement() {
    return _GetSearchSongsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSearchSongsProvider && other.searchQuery == searchQuery;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchQuery.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetSearchSongsRef on AutoDisposeFutureProviderRef<List<SongModel>> {
  /// The parameter `searchQuery` of this provider.
  String get searchQuery;
}

class _GetSearchSongsProviderElement
    extends AutoDisposeFutureProviderElement<List<SongModel>>
    with GetSearchSongsRef {
  _GetSearchSongsProviderElement(super.provider);

  @override
  String get searchQuery => (origin as GetSearchSongsProvider).searchQuery;
}

String _$homeViewModelHash() => r'66178a24a20b5885ee5fb28186fa52876ef740ee';

/// See also [HomeViewModel].
@ProviderFor(HomeViewModel)
final homeViewModelProvider =
    AutoDisposeNotifierProvider<HomeViewModel, AsyncValue?>.internal(
  HomeViewModel.new,
  name: r'homeViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
