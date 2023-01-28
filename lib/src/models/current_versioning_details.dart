import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

class CurrentVersioningDetails {
  final int androidVersion;
  final int iosVersion;

  const CurrentVersioningDetails({
    required this.androidVersion,
    required this.iosVersion,
  });

  static Future<CurrentVersioningDetails?> fromPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final number = int.parse(packageInfo.buildNumber);

    return CurrentVersioningDetails(
      androidVersion: Platform.isAndroid ? number : -1,
      iosVersion: Platform.isIOS ? number : -1,
    );
  }

  int get platformVersion => Platform.isAndroid ? androidVersion : iosVersion;

  /// Overriding for a readable String representation of its instance.
  @override
  String toString() {
    return 'androidVersion: $androidVersion, iosVersion: $iosVersion';
  }
}
