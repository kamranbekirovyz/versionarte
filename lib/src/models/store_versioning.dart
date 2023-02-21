import 'package:flutter/foundation.dart';

/// A serverside representation model of the app versioning.
class StoreVersioning {
  const StoreVersioning({
    required this.android,
    required this.ios,
  });

  /// The versioning information for Android platform.
  final PlatformVersionarte android;

  /// The versioning information for iOS platform.
  final PlatformVersionarte ios;

  /// Creates an instance of [StoreVersioning] from a JSON [Map].
  factory StoreVersioning.fromJson(Map<String, dynamic> json) {
    return StoreVersioning(
      android: PlatformVersionarte.fromJson(json["android"]),
      ios: PlatformVersionarte.fromJson(json["ios"]),
    );
  }

  /// Returns a JSON [Map] representation of this object.
  Map<String, dynamic> toJson() {
    return {
      'android': android.toJson(),
      'ios': ios.toJson(),
    };
  }

  /// Returns the [PlatformVersionarte] object corresponding to the current platform.
  ///
  /// Throws an [UnimplementedError] if the current platform is not supported by the package.
  PlatformVersionarte get platformVersionarte {
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

class PlatformVersionarte {
  final ReleaseDetails minimum;
  final ReleaseDetails latest;
  final Availability availability;
  final Map<String?, List<String?>?>? changelog;

  const PlatformVersionarte({
    required this.minimum,
    required this.latest,
    required this.availability,
    required this.changelog,
  });

  factory PlatformVersionarte.fromJson(Map<String, dynamic> json) {
    final Map<String?, List<String?>?> changelog_ = {};

    json['changelog']?.forEach(
      (String? key, dynamic value) {
        changelog_[key] = value.cast<String?>();
      },
    );
    return PlatformVersionarte(
      minimum: ReleaseDetails.fromJson(json["minimum"]),
      latest: ReleaseDetails.fromJson(json["latest"]),
      availability: Availability.fromJson(json["availability"]),
      changelog: changelog_,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'minimum': minimum.toJson(),
      'latest': minimum.toJson(),
      'availability': availability.toJson(),
      'changelog': changelog,
    };
  }

  /// Returns the changelog for a given language code.
  ///
  /// If no changelog is available for the given language code, null is returned.
  List<String?>? getChangelogForLanguage(String languageCode) {
    return changelog?[languageCode];
  }
}

class Availability {
  final bool available;
  final String? message;
  final String? details;

  const Availability({
    required this.available,
    required this.message,
    required this.details,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      available: json["available"],
      message: json["message"],
      details: json["details"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'available': available,
      'message': message,
      'details': details,
    };
  }
}

class ReleaseDetails {
  final int number;
  final String name;

  const ReleaseDetails({
    required this.number,
    required this.name,
  });

  factory ReleaseDetails.fromJson(Map<String, dynamic> json) {
    return ReleaseDetails(
      number: json["number"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
    };
  }
}
