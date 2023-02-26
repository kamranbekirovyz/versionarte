import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:versionarte/versionarte.dart';

/// A class that represents the versioning details of the running app.
class LocalVersioning {
  /// Current version number of the running Android app.
  final int? androidVersionNumber;

  /// Current version number of the running iOS app.
  final int? iOSVersionNumber;

  /// Creates a new [LocalVersioning] instance with the given parameters.
  ///
  /// [androidVersionNumber] is the version number of the running Android app.
  ///
  /// [iOSVersionNumber] is the version number of the running iOS app.
  const LocalVersioning({
    this.androidVersionNumber,
    this.iOSVersionNumber,
  });

  /// Creates a new [LocalVersioning] instance from package information retrieved
  /// from the platform. Returns null if package information is unavailable.
  ///
  /// This method is used to create a new instance of [LocalVersioning] by reading
  /// the package information of the running app. It returns `null` if package information
  /// is unavailable, e.g. if the package is not installed or if the app is running on an unsupported platform.
  static Future<LocalVersioning?> fromPackageInfo() async {
    final packageInfo = await Versionarte.packageInfo;

    if (packageInfo == null) {
      return null;
    }

    final buildNumber = int.parse(packageInfo.buildNumber);

    return LocalVersioning(
      androidVersionNumber: Platform.isAndroid ? buildNumber : null,
      iOSVersionNumber: Platform.isIOS ? buildNumber : null,
    );
  }

  /// Returns the version number of the current platform.
  ///
  /// This method is used to get the version number of the current platform, which can be either
  /// Android or iOS. If the current platform is not supported by this package, an [UnimplementedError]
  /// is thrown.
  int? get currentPlatformVersionNumber {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidVersionNumber;
      case TargetPlatform.iOS:
        return iOSVersionNumber;
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

  /// Returns a readable [String] representation of this instance.
  ///
  /// This method is used to create a readable string representation of the [LocalVersioning] instance,
  /// which includes the version number of the current platform. It is mainly used for debugging purposes.
  @override
  String toString() {
    return 'Current platform version number: $currentPlatformVersionNumber';
  }
}
