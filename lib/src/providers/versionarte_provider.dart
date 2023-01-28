import 'dart:async';

import 'package:versionarte/src/models/serverside_versioning.dart';

abstract class VersionarteProvider {
  const VersionarteProvider();

  FutureOr<ServersideVersioning?> getVersioningDetails();
}
