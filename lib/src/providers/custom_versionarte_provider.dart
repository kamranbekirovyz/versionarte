import 'dart:async';

import 'package:versionarte/src/models/store_versioning.dart';
import 'package:versionarte/src/providers/versionarte_provider.dart';

/// This package has 2 type of remote `VersionarteProvider` to fetch serverside
/// versioning details of your app: [RemoteConfigVersionarteProvider] and
/// [RestfulVersionarteProvider].
///
/// If for some reason this does not satisfy your needs, you can always populate
/// `StoreVersioning` manually and get from any kind of provider.
/// (graphql, firestore etc.)
class CustomVersionarteProvider extends VersionarteProvider {
  final StoreVersioning _storeVersioning;

  CustomVersionarteProvider(
    StoreVersioning storeVersioning,
  ) : _storeVersioning = storeVersioning;

  /// Returns `StoreVersioning` object set at constructor.
  @override
  FutureOr<StoreVersioning> getStoreVersioning() {
    return _storeVersioning;
  }
}
