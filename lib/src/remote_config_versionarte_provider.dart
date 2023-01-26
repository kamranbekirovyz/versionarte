// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:versionarte/src/models/versioning_details.dart';
// import 'package:versionarte/src/versionarte_provider.dart';

// class RemoteConfigVersionarteProvider extends VersionarteProvider {
//   FirebaseRemoteConfig? _remoteConfig;

//   /// Initializes [FirebaseRemoteConfig] for this project, if not initialized.
//   ///
//   /// By default `fetchTimeout` is set to 15 seconds, minimumFetchInterval to
//   /// Duration.zero.
//   Future<void> initialize(
//     RemoteConfigSettings? remoteConfigSettings,
//     FirebaseRemoteConfig? remoteConfig,
//   ) async {
//     _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

//     remoteConfigSettings = RemoteConfigSettings(
//       fetchTimeout: const Duration(seconds: 15),
//       minimumFetchInterval: Duration.zero,
//     );

//     await _remoteConfig?.setConfigSettings(remoteConfigSettings);
//   }

//   // @override
//   // Future<ServerdideVersioningDetails> getServerdideVersioningDetails() {
//   //   return Future.value(ServerdideVersioningDetails());
//   // }
// }
