import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:versionarte/versionarte.dart';

class VersionarteIndicator extends StatelessWidget {
  final TextStyle textStyle;

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

        // TODO: add null checks
        return Text(
          '${snapshot.data?.appName} v${snapshot.data?.version}+${snapshot.data?.buildNumber}',
          style: textStyle,
        );
      },
    );
  }
}
