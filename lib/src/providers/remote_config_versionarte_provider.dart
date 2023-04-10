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

  /// Creates a new instance of [RemoteConfigVersionarteProvider].
  ///
  /// The `keyName` parameter is used to specify the key name for the Firebase Remote Config to
  /// fetch. By default, it's set to "versionarte".
  ///
  /// To see an example of the JSON file that is uploaded to Firebase Remote Config, check the
  /// /versionarte.json file.
  const RemoteConfigVersionarteProvider({
    this.keyName = 'versionarte',
  });

  /// Fetches the JSON uploaded to Firebase Remote Config and decodes it into an instance of
  /// [StoreVersioning].
  @override
  FutureOr<StoreVersioning?> getStoreVersioning() async {
    StoreVersioning? storeVersioning;

    try {
      await FirebaseRemoteConfig.instance.fetch();

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
