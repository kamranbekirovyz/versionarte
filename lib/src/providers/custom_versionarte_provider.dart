import 'dart:async';

import 'package:versionarte/src/models/serverside_versioning_details.dart';
import 'package:versionarte/src/providers/versionarte_provider.dart';

/// This package has 2 type of remote [VersionarteProvider] to fetch serverside
/// versioning details of your app: [RemoteConfigVersionarteProvider] and
/// [RestfulVersionarteProvider].
///
/// If for some reason this does not satisfy your needs, you can always populate
/// [ServersideVersioningDetails] manually and get from any kind of provider.
/// (graphql, firestore etc.)
class CustomVersionarteProvider extends VersionarteProvider {
  final ServersideVersioningDetails _serversideVersioningDetails;

  CustomVersionarteProvider(
    ServersideVersioningDetails versioningDetails,
  ) : _serversideVersioningDetails = versioningDetails;

  /// Returns [ServersideVersioningDetails] object set at constructor.
  @override
  FutureOr<ServersideVersioningDetails> getVersioningDetails() {
    return _serversideVersioningDetails;
  }
}
