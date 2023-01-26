import 'package:versionarte/src/models/serverside_versioning_details.dart';

abstract class VersionarteProvider {
  Future<ServersideVersioningDetails> getServersideVersioningDetails();
}
