import 'package:flutter/foundation.dart';

/// A serverside representation model of the app versioning.
class StoreVersioning {
  const StoreVersioning({
    required this.android,
    required this.ios,
  });

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

  /// Returns a JSON [Map] representation of this object.
  Map<String, dynamic> toJson() {
    return {
      'android': android.toJson(),
      'ios': ios.toJson(),
    };
  }

  /// Returns the [PlatformStoreDetails] object corresponding to the current platform.
  ///
  /// Throws an [UnimplementedError] if the current platform is not supported by the package.
  StorePlatformDetails get currentPlatformStoreDetails {
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

  @override
  String toString() {
    return toJson().toString();
  }
}

class StorePlatformDetails {
  final ReleaseDetails minimum;
  final ReleaseDetails latest;
  final Availability availability;

  const StorePlatformDetails({
    required this.minimum,
    required this.latest,
    required this.availability,
  });

  factory StorePlatformDetails.fromJson(Map<String, dynamic> json) {
    return StorePlatformDetails(
      minimum: ReleaseDetails.fromJson(json["minimum"]),
      latest: ReleaseDetails.fromJson(json["latest"]),
      availability: Availability.fromJson(json["availability"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'minimum': minimum.toJson(),
      'latest': minimum.toJson(),
      'availability': availability.toJson(),
    };
  }
}

class Availability {
  final bool available;
  final Map<String?, UnavailabilityText?>? content;

  const Availability({
    required this.available,
    required this.content,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    final Map<String?, UnavailabilityText?> content_ = {};

    json['content']?.forEach(
      (String? key, dynamic value) {
        content_[key] = UnavailabilityText.fromJson(value);
      },
    );

    return Availability(
      available: json["available"],
      content: content_,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'available': available,
      'content': content,
    };
  }

  /// Get content for unavailable app in the given language.
  ///
  /// If no content is available for the given language code, null is returned.
  UnavailabilityText? getContentForLanguage(String languageCode) {
    return content?[languageCode];
  }
}

class UnavailabilityText {
  final String? message;
  final String? details;

  const UnavailabilityText({
    required this.message,
    required this.details,
  });

  factory UnavailabilityText.fromJson(Map<String, dynamic> json) {
    return UnavailabilityText(
      message: json["message"],
      details: json["details"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
