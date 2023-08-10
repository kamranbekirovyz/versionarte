import 'dart:async';
import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:versionarte/src/models/versionarte_comparator.dart';
import 'package:versionarte/src/utilities/logger.dart';
import 'package:versionarte/src/utilities/pretty_json.dart';
import 'package:versionarte/versionarte.dart';

/// A utility class that helps to check the version of the app on the device
/// against the version available on the store.
class Versionarte {
  /// The package information retrieved from the device. This is used to get the
  /// current version of the app and stored in a static variable to avoid
  /// multiple calls to the `package_info` package.
  static PackageInfo? _packageInfo;

  /// Retrieves package information from the platform. This method uses the
  /// `package_info_plus` package to get the package information.
  static Future<PackageInfo> get packageInfo async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _packageInfo!;
  }

  /// Checks app's versioning and availability status.
  ///
  /// Parameters:
  /// - versionarteProvider: A [VersionarteProvider] instance to retrieve
  /// [StoreVersioning] stored remotely.
  /// - versionarteComparator: A [VersionarteComparator] instance to customize the comparison technique.
  ///
  /// Returns:
  /// - A [Future] that resolves to a [VersionarteResult] instance which contains
  /// the versioning and availability status of the app.
  static Future<VersionarteResult> check({
    required VersionarteProvider versionarteProvider,
    VersionarteComparator versionarteComparator = VersionarteComparator.version,
  }) async {
    try {
      final info = await packageInfo;
      final platformVersion = Version.parse(info.version);
      final platformName = Platform.operatingSystem;

      logVersionarte('Platform: $platformName, version: $platformVersion');
      logVersionarte('Provider: ${versionarteProvider.runtimeType}');

      final storeVersioning = await versionarteProvider.getStoreVersioning();

      if (storeVersioning == null) {
        logVersionarte(
            'Failed to get store versioning information using ${versionarteProvider.runtimeType}.');

        return VersionarteResult(VersionarteStatus.unknown);
      }

      logVersionarte('StoreVersioning: ${prettyJson(storeVersioning)}');

      final storeDetails = storeVersioning.storeDetailsForPlatform;

      if (storeDetails == null) {
        logVersionarte('No store details found for platform $platformName.');

        return VersionarteResult(VersionarteStatus.unknown);
      }

      if (!storeDetails.status.active) {
        return VersionarteResult(
          VersionarteStatus.appInactive,
          details: storeDetails,
        );
      } else {
        switch (versionarteComparator) {
          case VersionarteComparator.version:
            final minimumVersion = Version.parse(storeDetails.version.minimum);
            final latestVersion = Version.parse(storeDetails.version.latest);

            final minimumDifference = platformVersion.compareTo(minimumVersion);
            final latestDifference = platformVersion.compareTo(latestVersion);

            final status = minimumDifference.isNegative
                ? VersionarteStatus.mustUpdate
                : latestDifference.isNegative
                    ? VersionarteStatus.shouldUpdate
                    : VersionarteStatus.upToDate;

            return VersionarteResult(
              status,
              details: storeDetails,
            );
          case VersionarteComparator.buildNumber:
            final platformBuildNumber = int.tryParse(info.buildNumber);
            final minimumBuildNumber =
                int.tryParse(storeDetails.version.minimum);
            final latestBuildNumber = int.tryParse(storeDetails.version.latest);

            if (platformBuildNumber == null) {
              throw const FormatException(
                  'Failed to parse build number from platform version. the build number must be an integer.');
            }

            if (minimumBuildNumber == null) {
              throw const FormatException(
                  'Failed to parse build number from minimum version. the build number must be an integer.');
            }

            if (latestBuildNumber == null) {
              throw const FormatException(
                  'Failed to parse build number from latest version. the build number must be an integer.');
            }

            final minimumDifference =
                platformBuildNumber.compareTo(minimumBuildNumber);
            final latestDifference =
                platformBuildNumber.compareTo(latestBuildNumber);

            final status = minimumDifference.isNegative
                ? VersionarteStatus.mustUpdate
                : latestDifference.isNegative
                    ? VersionarteStatus.shouldUpdate
                    : VersionarteStatus.upToDate;

            return VersionarteResult(
              status,
              details: storeDetails,
            );
        }
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

  /// Opens the app's page on the Play Store on Android and the App Store on iOS
  ///
  /// If launch the store for the platform is not supported returns `false`.
  ///
  /// Parameters:
  ///   - `appleAppId` (int): The app ID of the app on the App Store (iOS).
  ///     If the app is not published on the App Store, pass `null`.
  ///   - `androidPackageName` (String): The package name of the app (Android)
  ///     retrieved automatically from the device's `package_info` package
  ///
  /// Returns:
  ///   - A `Future<bool>` that indicates whether the URL was successfully
  ///     launched or not.
  static Future<bool> launchStore({
    required int? appleAppId,
    String? androidPackageName,
  }) async {
    const mode = LaunchMode.externalApplication;

    if (Platform.isAndroid) {
      androidPackageName ??= (await packageInfo).packageName;

      return launchUrl(
        Uri.parse(
          'https://play.google.com/store/apps/details?id=$androidPackageName',
        ),
        mode: mode,
      );
    } else if (Platform.isIOS) {
      return launchUrl(
        Uri.parse(
          'https://apps.apple.com/app/id$appleAppId',
        ),
        mode: mode,
      );
    } else {
      logVersionarte(
          'Opening store for ${Platform.operatingSystem} platform is not supported.');
      return false;
    }
  }
}
