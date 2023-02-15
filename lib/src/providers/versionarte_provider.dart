import 'dart:async';

import 'package:versionarte/src/models/store_versioning.dart';

/// Interface for serverside store versioning information providers.
abstract class VersionarteProvider {
  const VersionarteProvider();

  FutureOr<StoreVersioning?> getStoreVersioning();
}
