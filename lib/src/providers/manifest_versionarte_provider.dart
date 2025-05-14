import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:versionarte/versionarte.dart';

/// A [VersionarteProvider] that helps pasre data to [DistributionManifest] 
class ManifestVersionarteProvider extends VersionarteProvider {

  /// The data to be parsed into a [DistributionManifest] object.
  final dynamic data;

  /// Creates a new instance of [ManifestVersionarteProvider].
  ///
  /// The [data] parameter is the data to be parsed into a [DistributionManifest] object. 
  /// This is expected to be a JSON format that can be parsed into a [DistributionManifest].
  /// The [data] parameter is required.
  const ManifestVersionarteProvider({
    required this.data,
  });

  /// Parses the given data into a [DistributionManifest] object.
  @override
  FutureOr<DistributionManifest?> getDistributionManifest() async {
    return compute(parseDistributionManifest, data);
  }
}

DistributionManifest parseDistributionManifest(dynamic json) {
  return DistributionManifest.fromJson(json);
}
