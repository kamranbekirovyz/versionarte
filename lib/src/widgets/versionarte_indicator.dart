import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:versionarte/versionarte.dart';

class VersionarteIndicator extends StatelessWidget {
  /// The style to use for this widget's text.
  ///
  /// Defaults to:
  /// ```dart
  /// const TextStyle(
  ///   fontSize: 14.0,
  ///   height: 16.0 / 14.0,
  ///   color: Colors.grey,
  /// )
  /// ```
  final TextStyle? textStyle;

  /// Version indicator widget as example: "Versionarte v1.0.0+1"
  ///
  /// Information is retrieved using partly [PackageInfo] and [LocalVersioning]
  /// you've provided to `Versionarte.check` method.
  ///
  /// Make sure you call `Versionarte.check` throughout the lifecycle of your
  /// app (probably at start-up of the app),  since `LocalVersioning` is cached
  /// and re-used for building this widget.
  const VersionarteIndicator({
    Key? key,
    this.textStyle = const TextStyle(
      fontSize: 14.0,
      height: 16.0 / 14.0,
      color: Colors.grey,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo?>(
      future: Future.value(Versionarte.packageInfo),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final info = snapshot.requireData!;
        final appName = info.appName;
        final versionName = info.version;
        final versionNumber =
            Versionarte.localVersioning?.platformVersion ?? info.buildNumber;

        return Text(
          '$appName v$versionName+$versionNumber',
          style: textStyle,
        );
      },
    );
  }
}
