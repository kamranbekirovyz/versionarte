import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:versionarte/src/models/store_versioning.dart';
import 'package:versionarte/src/providers/versionarte_provider.dart';

/// A [VersionarteProvider] that retrieves [StoreVersioning] information stored in Firebase
/// Remote Config using the key name "versionarte" or a different key name specified through
/// the `keyName` constructor parameter.
class RemoteConfigVersionarteProvider extends VersionarteProvider {
  late final String _keyName;
  late final RemoteConfigSettings _remoteConfigSettings;
  late final bool _initializeRemoteConfig;

  /// Creates a new instance of [RemoteConfigVersionarteProvider].
  ///
  /// The `initializeRemoteConfig` parameter indicates whether or not the Firebase Remote Config
  /// settings should be initialized. By default, it's set to `true`.
  ///
  /// The `remoteConfigSettings` parameter allows you to set the fetch timeout and minimum fetch
  /// interval for Firebase Remote Config. By default, `fetchTimeout` is set to 7 seconds and
  /// `minimumFetchInterval` to `Duration.zero`.
  ///
  /// The `keyName` parameter is used to specify the key name for the Firebase Remote Config to
  /// fetch. By default, it's set to "versionarte".
  ///
  /// To see an example of the JSON file that is uploaded to Firebase Remote Config, check the
  /// /versionarte.json file.
  RemoteConfigVersionarteProvider({
    bool initializeRemoteConfig = true,
    RemoteConfigSettings? remoteConfigSettings,
    String keyName = 'versionarte',
  }) {
    _keyName = keyName;
    _initializeRemoteConfig = initializeRemoteConfig;

    if (initializeRemoteConfig) {
      _remoteConfigSettings = remoteConfigSettings ??
          RemoteConfigSettings(
            fetchTimeout: const Duration(seconds: 7),
            minimumFetchInterval: Duration.zero,
          );
    }
  }

  /// Initializes the Firebase Remote Config settings.
  ///
  /// The `settings` parameter is a [RemoteConfigSettings] instance that specifies the fetch
  /// timeout and minimum fetch interval for Firebase Remote Config.
  Future<void> _initialize(RemoteConfigSettings settings) async {
    return FirebaseRemoteConfig.instance.setConfigSettings(settings);
  }

  /// Fetches the JSON uploaded to Firebase Remote Config and decodes it into an instance of
  /// [StoreVersioning].
  ///
  /// Returns a [Future] that resolves to a [StoreVersioning] instance or `null` if there was an
  /// error while fetching or decoding the JSON.
  @override
  FutureOr<StoreVersioning?> getStoreVersioning() async {
    StoreVersioning? storeVersioning;

    try {
      if (_initializeRemoteConfig) {
        await _initialize(_remoteConfigSettings);
      }

      await FirebaseRemoteConfig.instance.fetchAndActivate();

      final versionarteString =
          FirebaseRemoteConfig.instance.getString(_keyName);
      final versionarteDecoded = jsonDecode(versionarteString);

      storeVersioning = StoreVersioning.fromJson(versionarteDecoded);
    } catch (e, s) {
      debugPrint('[VERSIONARTE] Exception: $e');
      debugPrint('[VERSIONARTE] Stack Trace: $s');
    }

    return storeVersioning;
  }
}
