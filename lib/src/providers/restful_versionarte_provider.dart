import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:versionarte/src/helpers/logger.dart';
import 'package:versionarte/src/models/serverside_versioning.dart';
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
  FutureOr<ServersideVersioning?> getVersioningDetails() async {
    final client = http.Client();

    final headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    if (_headers != null) {
      headers.addEntries(_headers!.entries);
    }

    logV('Getting serverside versioning details from RESTful API\nEndpoint: $_endpoint\nRequest headers: $_headers');

    final response = await client.get(
      Uri.parse(_endpoint),
      headers: headers,
    );

    logV('Status code: ${response.statusCode}');
    logV('Response body: ${response.body}');

    // TODO: pretty print the response body

    final json = jsonDecode(response.body);

    return ServersideVersioning.fromJson(json);
  }
}
