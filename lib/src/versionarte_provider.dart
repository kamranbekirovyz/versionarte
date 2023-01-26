import 'package:versionarte/src/models/versioning_details.dart';

abstract class VersionarteProvider {
  Future<ServerdideVersioningDetails> getServerdideVersioningDetails();
}
