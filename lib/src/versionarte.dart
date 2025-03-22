import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';
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
  /// [StoreVersioning] stored remotely.
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

      final storeVersioning = await versionarteProvider.getStoreVersioning();

      if (storeVersioning == null) {
        logVersionarte(
            'Failed to get store versioning information using ${versionarteProvider.runtimeType}.');

        return VersionarteResult(VersionarteStatus.unknown);
      }

      logVersionarte('StoreVersioning: ${prettyJson(storeVersioning)}');

      final StorePlatformDetails? storeDetails = storeVersioning.current;

      if (storeDetails == null) {
        logVersionarte('No store details found for platform $platformName.');

        return VersionarteResult(VersionarteStatus.unknown);
      }

      if (!storeDetails.status.active) {
        return VersionarteResult(
          VersionarteStatus.inactive,
          platforms: storeVersioning,
        );
      } else {
        final Version minimumVersion =
            Version.parse(storeDetails.version.minimum);
        final Version latestVersion =
            Version.parse(storeDetails.version.latest);

        final int minimumDifference = platformVersion.compareTo(minimumVersion);
        final int latestDifference = platformVersion.compareTo(latestVersion);

        final VersionarteStatus status = minimumDifference.isNegative
            ? VersionarteStatus.forcedUpdate
            : latestDifference.isNegative
                ? VersionarteStatus.outdated
                : VersionarteStatus.upToDate;

        return VersionarteResult(
          status,
          platforms: storeVersioning,
        );
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
}
