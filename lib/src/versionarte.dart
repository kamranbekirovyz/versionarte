import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:versionarte/src/models/versionarte_comparator.dart';
import 'package:versionarte/src/utilities/logger.dart';
import 'package:versionarte/src/utilities/pretty_json.dart';
import 'package:versionarte/versionarte.dart';

/// Checks the version of the app on the device against the version on the store.
class Versionarte {
  /// The package information. Stored in a static variable to avoid multiple calls
  static PackageInfo? _packageInfo;

  /// Retrieves package information from the platform.
  static Future<PackageInfo> get packageInfo async {
    _packageInfo ??= await PackageInfo.fromPlatform();

    return _packageInfo!;
  }

  /// Checks app's versioning and availability status.
  ///
  /// Parameters:
  /// - versionarteProvider: A [VersionarteProvider] instance to retrieve
  /// [DistributionManifest] stored remotely.
  ///
  /// Returns:
  /// - A [Future] that resolves to a [VersionarteResult] instance which contains
  /// the versioning and availability status of the app.
  static Future<VersionarteResult> check({
    required VersionarteProvider versionarteProvider,
  }) async {
    try {
      final PackageInfo info = await packageInfo;
      final Version platformVersion = Version.parse(info.version);
      final String platformName = defaultTargetPlatform.name;

      logVersionarte('Platform: $platformName, version: $platformVersion');
      logVersionarte('Provider: ${versionarteProvider.runtimeType}');

      final DistributionManifest? manifest =
          await versionarteProvider.getDistributionManifest();

      if (manifest == null) {
        logVersionarte(
            'Failed to get distribution manifest using ${versionarteProvider.runtimeType}.');

        return VersionarteResult(VersionarteStatus.unknown);
      }

      logVersionarte('DistributionManifest: ${prettyJson(manifest)}');

      final PlatformDistributionInfo? storeDetails = manifest.currentPlatform;

      if (storeDetails == null) {
        logVersionarte('No store details found for platform $platformName.');

        return VersionarteResult(VersionarteStatus.unknown);
      }

      if (!storeDetails.status.active) {
        return VersionarteResult(
          VersionarteStatus.inactive,
          manifest: manifest,
        );
      } else {
        final Version minimumVersion =
            Version.parse(storeDetails.version.minimum);
        final Version latestVersion =
            Version.parse(storeDetails.version.latest);
        return switch (versionarteProvider.comparator) {
          VersionarteComparator.versionOnly => _checkByVersionOnly(
              latestVersion: latestVersion,
              minimumVersion: minimumVersion,
              platformVersion: platformVersion,
              manifest: manifest,
            ),
          VersionarteComparator.versionAndBuildNumber =>
            _checkByVersionAndBuildNumber(
              latestVersion: latestVersion,
              minimumVersion: minimumVersion,
              platformVersion: platformVersion,
              manifest: manifest,
            ),
          VersionarteComparator.buildNumberOnly => _checkByBuildNumberOnly(
              latestVersion: latestVersion,
              minimumVersion: minimumVersion,
              platformVersion: platformVersion,
              manifest: manifest,
            ),
        };
      }
    } on FormatException catch (e) {
      final error = versionarteProvider is RemoteConfigVersionarteProvider
          ? 'Failed to parse JSON retrieved from Firebase Remote Config. '
              'Check out the example JSON file at path /versionarte.json, and make sure that the one you\'ve uploaded matches the pattern. '
              'If you have uploaded it with a custom key name make sure you specify keyName as a constructor parameter to RemoteConfigVersionarteProvider.'
          : versionarteProvider is RestfulVersionarteProvider
              ? 'Failed to parse JSON received from RESTful API endpoint. '
                  'Check out the example JSON file at path /versionarte.json, and make sure that endpoint response body matches the pattern.'
              : e.toString();

      logVersionarte(error, error: e);

      return VersionarteResult(VersionarteStatus.unknown);
    } catch (e, s) {
      logVersionarte(
        'An error occurred while checking for updates. '
        'Check the debug console to see the error and stack trace.',
        error: e,
        stackTrace: s,
      );

      return VersionarteResult(VersionarteStatus.unknown);
    }
  }

  /// Launches the download URL for the app on the platform.
  ///
  /// Parameters:
  ///  - Map<TargetPlatform, String> `data`: A map of download URLs for each
  ///   platform. The key is the platform and the value is the download URL.
  static Future<void> launchDownloadUrl(
    Map<TargetPlatform, String?> data,
  ) async {
    final TargetPlatform platform = defaultTargetPlatform;
    final String? url = data[platform];

    if (url == null) {
      logVersionarte(
        'No download URL found for platform $platform.',
      );
      return;
    }

    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }

  /// The function `_checkByVersionOnly` compares the platform version with the latest and minimum
  /// versions to determine if an update is required.
  ///
  /// Args:
  ///   latestVersion (Version): The `latestVersion` parameter represents the most recent version
  /// available for a particular software or application.
  ///   minimumVersion (Version): The `minimumVersion` parameter represents the minimum required version
  /// that the platform must have in order to function properly.
  ///   platformVersion (Version): The `platformVersion` parameter is the version of the platform or
  /// system that you are checking against. It is compared with the `latestVersion` and `minimumVersion`
  /// to determine the status of the version in relation to these two versions.
  ///   manifest (DistributionManifest): The code snippet you provided is a method named
  /// `_checkByVersionOnly` that takes in several parameters including `latestVersion`,
  /// `minimumVersion`, `platformVersion`, and an optional parameter `manifest` of type
  /// `DistributionManifest`.
  ///
  /// Returns:
  ///   The function `_checkByVersionOnly` is returning a `VersionarteResult` object based on the
  /// comparison of the `platformVersion` with the `minimumVersion` and `latestVersion`. The returned
  /// `VersionarteResult` object contains a `VersionarteStatus` value indicating whether the platform
  /// version requires a forced update, is outdated, or is up to date. The `manifest` parameter is also
  /// included
  static VersionarteResult _checkByVersionOnly(
      {required Version latestVersion,
      required Version minimumVersion,
      required Version platformVersion,
      DistributionManifest? manifest}) {
    final int minimumDifference = platformVersion.compareTo(minimumVersion);
    final int latestDifference = platformVersion.compareTo(latestVersion);
    return switch (minimumDifference) {
      _ when minimumDifference.isNegative => VersionarteResult(
          VersionarteStatus.forcedUpdate,
          manifest: manifest,
        ),
      _ when latestDifference.isNegative => VersionarteResult(
          VersionarteStatus.outdated,
          manifest: manifest,
        ),
      _ => VersionarteResult(
          VersionarteStatus.upToDate,
          manifest: manifest,
        ),
    };
  }

  /// The function `_checkByVersionAndBuildNumber` compares the platform version with the latest and
  /// minimum versions to determine the update status.
  ///
  /// Args:
  ///   latestVersion (Version): The code snippet you provided is a method that checks the version and
  /// build number of a platform against the latest version and minimum version. Based on the
  /// comparisons, it returns a `VersionarteResult` object with a corresponding `VersionarteStatus`.
  ///   minimumVersion (Version): The `minimumVersion` parameter represents the minimum version that your
  /// platform should have in order to function properly. This function `_checkByVersionAndBuildNumber`
  /// compares the platform version with the minimum version and the latest version to determine the
  /// status of the platform version. It also considers the build numbers of the platform
  ///   platformVersion (Version): The `platformVersion` parameter represents the version of the platform
  /// you are working with. It is compared to the `latestVersion` and `minimumVersion` to determine the
  /// status of the version and build number. The function `_checkByVersionAndBuildNumber` calculates the
  /// differences between the platform version and the
  ///   manifest (DistributionManifest): The code snippet you provided is a method that checks the
  /// version and build number of a platform against the latest version and minimum version. Based on the
  /// comparisons, it returns a `VersionarteResult` object with a corresponding `VersionarteStatus`.
  ///
  /// Returns:
  ///   The function `_checkByVersionAndBuildNumber` is returning a `VersionarteResult` object based on
  /// the comparison of the platform version with the latest version and minimum version. The returned
  /// `VersionarteResult` object contains a `VersionarteStatus` indicating whether the platform version
  /// requires a forced update, is outdated, or is up to date. The `manifest` parameter is also included
  /// in the returned object
  static VersionarteResult _checkByVersionAndBuildNumber(
      {required Version latestVersion,
      required Version minimumVersion,
      required Version platformVersion,
      DistributionManifest? manifest}) {
    final int minimumDifference = platformVersion.compareTo(minimumVersion);
    final int latestDifference = platformVersion.compareTo(latestVersion);
    final int platformBuild = _extractBuildNumber(platformVersion);
    final int latestBuild = _extractBuildNumber(latestVersion);
    return switch (minimumDifference) {
      _ when minimumDifference.isNegative => VersionarteResult(
          VersionarteStatus.forcedUpdate,
          manifest: manifest,
        ),
      _ when latestDifference.isNegative => VersionarteResult(
          VersionarteStatus.outdated,
          manifest: manifest,
        ),
      _ when platformBuild < latestBuild => VersionarteResult(
          VersionarteStatus.outdated,
          manifest: manifest,
        ),
      _ => VersionarteResult(
          VersionarteStatus.upToDate,
          manifest: manifest,
        ),
    };
  }

  /// This Dart function extracts the build number from a Version object, returning 0 if no build number
  /// is found.
  ///
  /// Args:
  ///   version (Version): The `_extractBuildNumber` function takes a `Version` object as a parameter.
  /// The function extracts the build number from the `Version` object and returns it as an integer. If
  /// the build number is not present or cannot be parsed as an integer, the function returns 0.
  ///
  /// Returns:
  ///   The method `_extractBuildNumber` returns an integer value, which is either the last build number
  /// extracted from the `Version` object or 0 if the build number is empty or cannot be parsed as an
  /// integer.
  static int _extractBuildNumber(Version version) {
    if (version.build.isEmpty) return 0;
    final lastBuildPart = version.build.lastOrNull.toString();
    final number = int.tryParse(lastBuildPart);
    return number ?? 0;
  }

  /// The function `_checkByBuildNumberOnly` compares the build numbers of different versions to
  /// determine the status of the platform version.
  ///
  /// Args:
  ///   latestVersion (Version): The `latestVersion` parameter represents the latest version of the
  /// software.
  ///   minimumVersion (Version): The `minimumVersion` parameter represents the minimum version that
  /// your platform should have. In the provided code snippet, the build number is extracted from this
  /// version to compare it with the platform's build number. If the platform's build number is lower
  /// than the minimum build number, the result will indicate a forced
  ///   platformVersion (Version): The `_checkByBuildNumberOnly` function compares the build numbers of
  /// the platform version, latest version, and minimum version to determine the status of the version
  /// artefact. It then returns a `VersionarteResult` based on the comparisons.
  ///   manifest (DistributionManifest): The code snippet you provided is a method named
  /// `_checkByBuildNumberOnly` that takes in several parameters including `latestVersion`,
  /// `minimumVersion`, `platformVersion`, and an optional parameter `manifest` of type
  /// `DistributionManifest`.
  ///
  /// Returns:
  ///   The function `_checkByBuildNumberOnly` returns a `VersionarteResult` object based on the
  /// comparison of build numbers extracted from the input versions. The returned `VersionarteResult`
  /// object contains a `VersionarteStatus` indicating whether the platform version requires a forced
  /// update, is outdated, or is up to date. The `manifest` parameter is also included in the returned
  /// result.
  static VersionarteResult _checkByBuildNumberOnly(
      {required Version latestVersion,
      required Version minimumVersion,
      required Version platformVersion,
      DistributionManifest? manifest}) {
    final int platformBuild = _extractBuildNumber(platformVersion);
    final int latestBuild = _extractBuildNumber(latestVersion);
    final int minimumBuild = _extractBuildNumber(latestVersion);
    final int minimumBuildDifference = platformBuild.compareTo(minimumBuild);
    final int latestBuildDifference = platformBuild.compareTo(latestBuild);
    return switch (minimumBuildDifference) {
      _ when minimumBuildDifference.isNegative => VersionarteResult(
          VersionarteStatus.forcedUpdate,
          manifest: manifest,
        ),
      _ when latestBuildDifference.isNegative => VersionarteResult(
          VersionarteStatus.outdated,
          manifest: manifest,
        ),
      _ when platformBuild < latestBuild => VersionarteResult(
          VersionarteStatus.outdated,
          manifest: manifest,
        ),
      _ => VersionarteResult(
          VersionarteStatus.upToDate,
          manifest: manifest,
        ),
    };
  }
}
