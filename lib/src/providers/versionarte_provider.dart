import 'dart:async';

import 'package:versionarte/src/models/serverside_versioning_details.dart';

abstract class VersionarteProvider {
  const VersionarteProvider();

  FutureOr<ServersideVersioningDetails?> getVersioningDetails();
}
