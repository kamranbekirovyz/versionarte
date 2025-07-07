import 'dart:async';

import 'package:versionarte/src/models/versionarte_comparator.dart';
import 'package:versionarte/versionarte.dart';

/// An interface for a server-side store versioning information provider.
///
/// This interface defines the contract for objects that provide store versioning information
/// from a remote data source, such as a server. Implementations of this interface should
/// provide a concrete implementation for the [getDistributionManifest] method, which should return
/// a [DistributionManifest] object or null if the versioning information cannot be retrieved.
abstract class VersionarteProvider {
  /// Constructs a [VersionarteProvider].
  const VersionarteProvider({
    /// In the `VersionarteProvider` abstract class constructor, `this.comparator =
    /// VersionarteComparator.versionOnly,` is setting a default value for the `comparator` field. If no
    /// value is provided for `comparator` when creating an instance of a class that implements
    /// `VersionarteProvider`, it will default to `VersionarteComparator.versionOnly`. This ensures that
    /// the `comparator` field is initialized with a default value if not explicitly provided during
    /// object creation.
    this.comparator = VersionarteComparator.versionOnly,
  });

  /// Determines the comparison mode for versioning or build numbers.
  /// By default, it's set to `versionOnly`.
  /// See [VersionarteComparator] for all possible values.
  final VersionarteComparator comparator;

  /// Returns the store versioning information from a remote data source.
  ///
  /// This method should be implemented to retrieve store versioning information from a remote
  /// data source. If the information is available, it should be returned as a [DistributionManifest]
  /// object. If the information cannot be retrieved, the method should return null.
  ///
  /// Throws an [Exception] if an error occurs while retrieving the versioning information.
  FutureOr<DistributionManifest?> getDistributionManifest();
}
