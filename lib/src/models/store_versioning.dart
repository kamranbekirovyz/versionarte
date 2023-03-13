import 'package:flutter/foundation.dart';

/// A serverside representation model of the app versioning.
class StoreVersioning {
  const StoreVersioning({
    required this.android,
    required this.ios,
  });

  // TODO: can be optional  (null)

  /// The versioning information for Android platform.
  final StorePlatformDetails android;

  /// The versioning information for iOS platform.
  final StorePlatformDetails ios;

  /// Creates an instance of [StoreVersioning] from a JSON [Map].
  factory StoreVersioning.fromJson(Map<String, dynamic> json) {
    return StoreVersioning(
      android: StorePlatformDetails.fromJson(json["android"]),
      ios: StorePlatformDetails.fromJson(json["ios"]),
    );
  }

  /// Returns the [PlatformStoreDetails] object corresponding to the current platform.
  ///
  /// Throws an [UnimplementedError] if the current platform is not supported by the package.
  StorePlatformDetails get storeDetailsForPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      default:
        throw UnimplementedError(
          '$defaultTargetPlatform not implemented in this package',
        );
    }
  }
}

class StorePlatformDetails {
  final String minimum;
  final String latest;
  final bool active;
  final Map<String?, String?>? message;

  const StorePlatformDetails({
    required this.minimum,
    required this.latest,
    required this.active,
    required this.message,
  });

  factory StorePlatformDetails.fromJson(Map<String, dynamic> json) {
    return StorePlatformDetails(
      minimum: json["minimum"],
      latest: json["latest"],
      active: json["active"],
      message: json["message"],
    );
  }

  String? getMessageForLanguage(String code) {
    return message?[code];
  }
}
