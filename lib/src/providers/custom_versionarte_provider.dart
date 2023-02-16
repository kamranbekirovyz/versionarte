import 'dart:async';

import 'package:versionarte/src/models/store_versioning.dart';
import 'package:versionarte/src/providers/versionarte_provider.dart';

class CustomVersionarteProvider extends VersionarteProvider {
  final StoreVersioning _storeVersioning;

  /// A [VersionarteProvider] using which you can populate the data for
  /// [StoreVersioning] manually by hand.
  ///
  /// In most cases you would use prebuilt [VersionarteProvider]s that comes
  /// with this package: [RemoteConfigVersionarteProvider],
  /// [RestfulVersionarteProvider] or create your own [VersionarteProvider] by
  /// extending that class. But, if for some reason you would like to manually
  /// create [StoreVersioning], [CustomVersionarteProvider] will be helpful.
  CustomVersionarteProvider(
    StoreVersioning storeVersioning,
  ) : _storeVersioning = storeVersioning;

  /// Returns `StoreVersioning` object set at constructor.
  @override
  FutureOr<StoreVersioning> getStoreVersioning() {
    return _storeVersioning;
  }
}
