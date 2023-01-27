import 'dart:async';

import 'package:versionarte/src/models/serverside_versioning_details.dart';
import 'package:versionarte/src/providers/versionarte_provider.dart';

class CustomVersionarteProvider extends VersionarteProvider {
  final ServersideVersioningDetails _serversideVersioningDetails;

  CustomVersionarteProvider(
    ServersideVersioningDetails versioningDetails,
  ) : _serversideVersioningDetails = versioningDetails;

  @override
  FutureOr<ServersideVersioningDetails> getVersioningDetails() {
    return _serversideVersioningDetails;
  }
}
