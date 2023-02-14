import 'dart:async';

import 'package:versionarte/src/models/serverside_versioning.dart';

/// Interface for serverside versioning information providers.
abstract class VersionarteProvider {
  const VersionarteProvider();

  FutureOr<ServersideVersioning?> getVersioningDetails();
}
