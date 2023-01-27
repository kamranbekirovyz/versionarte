import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:versionarte/src/models/serverside_versioning_details.dart';
import 'package:versionarte/src/providers/versionarte_provider.dart';
import 'package:http/http.dart' as http;

class RestfulVersionarteProvider extends VersionarteProvider {
  final String _endpoint;
  final Map<String, String>? _headers;

  const RestfulVersionarteProvider(
    String endpoint, {
    Map<String, String>? headers,
  })  : _endpoint = endpoint,
        _headers = headers;

  @override
  FutureOr<ServersideVersioningDetails?> getVersioningDetails() async {
    final client = http.Client();

    final headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    if (_headers != null) {
      headers.addEntries(_headers!.entries);
    }

    final response = await client.get(
      Uri.parse(_endpoint),
      headers: headers,
    );

    final json = jsonDecode(response.body);

    return ServersideVersioningDetails.fromJson(json);
  }
}
