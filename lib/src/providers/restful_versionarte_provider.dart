import 'dart:async';

import 'package:versionarte/src/models/serverside_versioning_details.dart';
import 'package:versionarte/src/providers/versionarte_provider.dart';
import 'package:http/http.dart' as http;

class RestfulVersionarteProvider extends VersionarteProvider {
  final Uri _url;
  final Map<String, dynamic> _headers;

  const RestfulVersionarteProvider(
    Uri url,
    Map<String, dynamic> headers,
  )   : _url = url,
        _headers = headers;

  @override
  FutureOr<ServersideVersioningDetails?> getVersioningDetails() async {
    return null;
  }
}
