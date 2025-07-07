/// This Dart code defines an enumeration called `VersionarteComparator` with three possible values:
/// `versionOnly`, `versionAndBuildNumber`, and `buildNumberOnly`. This enum can be used to represent
/// different comparison modes for versioning or build numbers in a Dart program.
enum VersionarteComparator {
  /// In Dart, `versionOnly` is a value defined in the `VersionarteComparator` enumeration. It
  /// represents one of the possible comparison modes for versioning. When using this enum,
  /// `versionOnly` can be used to specify that only the version part of a version number should be
  /// considered during comparisons or operations.
  /// Example: 1.0.0 < 1.0.1
  versionOnly,

  /// The `versionAndBuildNumber` value in the `VersionarteComparator` enumeration represents a
  /// comparison mode where both the version and build number parts of a version number are considered
  /// during comparisons or operations. This means that when using this mode, both the version and build
  /// number components of a version number will be taken into account when determining the order or
  /// equality of two version numbers.
  // Example: 1.0.0 < 1.0.1+1
  versionAndBuildNumber,

  /// The `buildNumberOnly` value in the `VersionarteComparator` enumeration represents a comparison
  /// mode where only the build number part of a version number is considered during comparisons or
  /// operations. This means that when using this mode, only the build number component of a version
  /// number will be taken into account when determining the order or equality of two version numbers.
  /// Example: 1.0.1+1 < 1.0.1+2 (this will only compare the build number thus +1 and +2, ignoring the version)
  buildNumberOnly,
}
