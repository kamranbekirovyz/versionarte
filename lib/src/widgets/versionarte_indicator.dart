import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:versionarte/versionarte.dart';

/// A widget that displays the app version and name.
class VersionarteIndicator extends StatelessWidget {
  /// The style to use for this widget's text.
  ///
  /// If null, defaults to:
  ///
  /// ```
  /// const TextStyle(
  ///   fontSize: 14.0,
  ///   height: 16.0 / 14.0,
  ///   color: Colors.grey,
  /// )
  /// ```
  final TextStyle? textStyle;

  /// Constructs a new [VersionarteIndicator] widget.
  ///
  /// [textStyle] is the style to use for this widget's text. If null, the
  /// default style is used.
  ///
  /// The version information is retrieved using the [PackageInfo] package
  /// and the [LocalVersioning] class you've provided to the `Versionarte.check`
  /// method. Make sure you call `Versionarte.check` throughout the lifecycle
  /// of your app (probably at start-up of the app), since [LocalVersioning]
  /// is cached and re-used for building this widget.
  const VersionarteIndicator({
    Key? key,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo?>(
      future: Future.value(Versionarte.packageInfo),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // If the future hasn't completed yet, return an empty widget.
          return const SizedBox.shrink();
        }

        final info = snapshot.requireData!;
        final appName = info.appName;
        final versionName = info.version;

        // Use the platform version from LocalVersioning if available,
        // otherwise use the build number from PackageInfo.
        final versionNumber =
            Versionarte.localVersioning?.platformVersion ?? info.buildNumber;

        return Text(
          '$appName v$versionName+$versionNumber',
          style: textStyle ??
              const TextStyle(
                fontSize: 14.0,
                height: 16.0 / 14.0,
                color: Colors.grey,
              ),
        );
      },
    );
  }
}
