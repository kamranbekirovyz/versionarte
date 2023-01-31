import 'dart:io';

import 'package:versionarte/versionarte.dart';

class CurrentVersioning {
  /// Current version number of the running Android app.
  final int androidVersion;

  /// Current version number of the running iOS app.
  final int iosVersion;

  const CurrentVersioning({
    required this.androidVersion,
    required this.iosVersion,
  });

  /// Returns `CurrentVersioning` object from current platform's package
  /// info.
  static Future<CurrentVersioning?> fromPackageInfo() async {
    final packageInfo = await Versionarte.packageInfo;

    if (packageInfo == null) {
      throw 'Failed to get versioning details from PackageInfo';
    }

    final number = int.parse(packageInfo.buildNumber);

    return CurrentVersioning(
      androidVersion: Platform.isAndroid ? number : -1,
      iosVersion: Platform.isIOS ? number : -1,
    );
  }

  /// Version number of current platform.
  int get platformVersion => Platform.isAndroid ? androidVersion : iosVersion;

  /// Overriding for a readable String representation of its instance.
  @override
  String toString() {
    return 'androidVersion: $androidVersion, iosVersion: $iosVersion';
  }
}
