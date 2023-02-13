import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:versionarte/versionarte.dart';

class LocalVersioning {
  /// Current version number of the running Android app.
  final int? _androidVersion;

  /// Current version number of the running iOS app.
  final int? _iosVersion;

  const LocalVersioning({
    int? androidVersion,
    int? iosVersion,
  })  : _androidVersion = androidVersion,
        _iosVersion = iosVersion;

  /// Returns `LocalVersioning` object from current platform's package
  /// info.
  static Future<LocalVersioning?> fromPackageInfo() async {
    final packageInfo = await Versionarte.packageInfo;

    if (packageInfo == null) {
      throw 'Failed to get versioning details from PackageInfo';
    }

    final number = int.parse(packageInfo.buildNumber);

    return LocalVersioning(
      androidVersion: Platform.isAndroid ? number : -1,
      iosVersion: Platform.isIOS ? number : -1,
    );
  }

  /// Version number of current platform.
  int? get platformValue {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _androidVersion;
      case TargetPlatform.iOS:
        return _iosVersion;
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

  /// Overriding for a readable String representation of its instance.
  @override
  String toString() {
    return 'androidVersion: $_androidVersion, iosVersion: $_iosVersion';
  }
}
