import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

class CurrentVersioningDetails {
  /// Current version number of the running Android app.
  final int androidVersion;

  /// Current version number of the running iOS app.
  final int iosVersion;

  const CurrentVersioningDetails({
    required this.androidVersion,
    required this.iosVersion,
  });

  /// Returns [CurrentVersioningDetails] object from current platform's package
  /// info.
  static Future<CurrentVersioningDetails?> fromPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final number = int.parse(packageInfo.buildNumber);

    return CurrentVersioningDetails(
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
