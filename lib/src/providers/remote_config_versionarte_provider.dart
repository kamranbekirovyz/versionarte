import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:versionarte/src/models/store_versioning.dart';
import 'package:versionarte/src/providers/versionarte_provider.dart';
import 'package:versionarte/src/utilities/logger.dart';

/// A [VersionarteProvider] that retrieves [StoreVersioning] information stored in Firebase
/// Remote Config using the key name "versionarte" or a different key name specified through
/// the `keyName` constructor parameter.
class RemoteConfigVersionarteProvider extends VersionarteProvider {
  final String keyName;
  final bool initializeInternally;
  final RemoteConfigSettings? remoteConfigSettings;

  /// Creates a new instance of [RemoteConfigVersionarteProvider].
  ///
  /// Parameters:
  ///   - `keyName`: key name for the Firebase Remote Config to fetch.
  /// By default, it's set to "versionarte". Specify if you upload configuration
  /// JSON using a different key name.
  ///   - `initializeInternally`: if your project already initializes and
  /// configures Firebase Remote Config, set this to `false`. By default, it's
  /// set to `true`.
  ///   - `remoteConfigSettings`: settings for Firebase Remote Config if
  /// `initializeInternally` set to true. By default, it's set to:
  /// ```
  /// RemoteConfigSettings(
  ///  fetchTimeout: const Duration(seconds: 10),
  /// minimumFetchInterval: const Duration(seconds: 10),
  /// )
  /// ```
  const RemoteConfigVersionarteProvider({
    this.keyName = 'versionarte',
    this.initializeInternally = true,
    this.remoteConfigSettings,
  });

  /// Fetches the JSON uploaded to Firebase Remote Config and decodes it into an instance of
  /// [StoreVersioning].
  @override
  FutureOr<StoreVersioning?> getStoreVersioning() async {
    StoreVersioning? storeVersioning;

    try {
      if (initializeInternally) {
        final remoteConfigSettings_ = remoteConfigSettings ??
            RemoteConfigSettings(
              fetchTimeout: const Duration(seconds: 10),
              minimumFetchInterval: const Duration(seconds: 10),
            );

        await FirebaseRemoteConfig.instance.setConfigSettings(
          remoteConfigSettings_,
        );
        await FirebaseRemoteConfig.instance.fetchAndActivate();
      } else {
        await FirebaseRemoteConfig.instance.fetch();
      }

      final versionarteString =
          FirebaseRemoteConfig.instance.getString(keyName);
      final versionarteDecoded = jsonDecode(versionarteString);

      storeVersioning = StoreVersioning.fromJson(versionarteDecoded);
    } catch (e, s) {
      logVersionarte('Exception: $e');
      logVersionarte('Stack Trace: $s');
    }

    return storeVersioning;
  }
}
