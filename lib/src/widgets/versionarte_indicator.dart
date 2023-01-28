import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:versionarte/versionarte.dart';

class VersionarteIndicator extends StatelessWidget {
  const VersionarteIndicator({Key? key}) : super(key: key);

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
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        );
      },
    );
  }
}
