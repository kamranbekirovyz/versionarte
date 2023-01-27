import 'package:versionarte/src/models/serverside_versioning_details.dart';
import 'package:versionarte/src/models/versionarte_decision.dart';

class VersionarteResult {
  final VersionarteDecision decision;
  final ServersideVersioningDetails? details;
  final String? message;

  const VersionarteResult(this.decision, {this.details, this.message});
}
