import 'dart:async';

import 'package:versionarte/src/models/store_versioning.dart';

/// An interface for a server-side store versioning information provider.
///
/// This interface defines the contract for objects that provide store versioning information
/// from a remote data source, such as a server. The [getStoreVersioning] method should return
/// a [StoreVersioning] object or null if the versioning information cannot be retrieved.
abstract class VersionarteProvider {
  /// Constructs a [VersionarteProvider].
  const VersionarteProvider();

  /// Returns the store versioning information from a remote data source.
  ///
  /// Returns a [StoreVersioning] object if the versioning information is available,
  /// or null if the information cannot be retrieved.
  ///
  /// Throws an error if an exception occurs while retrieving the versioning information.
  FutureOr<StoreVersioning?> getStoreVersioning();
}
