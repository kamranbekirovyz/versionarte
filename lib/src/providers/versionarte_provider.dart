import 'dart:async';
import 'package:versionarte/src/models/store_versioning.dart';

/// An interface for a server-side store versioning information provider.
///
/// This interface defines the contract for objects that provide store versioning information
/// from a remote data source, such as a server. Implementations of this interface should
/// provide a concrete implementation for the [getStoreVersioning] method, which should return
/// a [StoreVersioning] object or null if the versioning information cannot be retrieved.
abstract class VersionarteProvider {
  /// Constructs a [VersionarteProvider].
  const VersionarteProvider();

  /// Returns the store versioning information from a remote data source.
  ///
  /// This method should be implemented to retrieve store versioning information from a remote
  /// data source. If the information is available, it should be returned as a [StoreVersioning]
  /// object. If the information cannot be retrieved, the method should return null.
  ///
  /// Throws an [Exception] if an error occurs while retrieving the versioning information.
  FutureOr<StoreVersioning?> getStoreVersioning();
}
