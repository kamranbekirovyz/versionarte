import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:versionarte/src/helpers/logger.dart';
import 'package:versionarte/src/models/store_versioning.dart';
import 'package:versionarte/src/providers/versionarte_provider.dart';
import 'package:http/http.dart' as http;

class RestfulVersionarteProvider extends VersionarteProvider {
  final String _url;
  final Map<String, String>? _headers;

  /// A `VersionarteProvider` that helps retrieve `StoreVersioning`
  /// information via sending an HTTP GET request with the given headers to the
  /// given URL.
  const RestfulVersionarteProvider(
    String url, {
    Map<String, String>? headers,
  })  : _url = url,
        _headers = headers;

  @override
  FutureOr<StoreVersioning?> getStoreVersioning() async {
    final client = http.Client();

    final headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    if (_headers != null) {
      headers.addEntries(_headers!.entries);
    }

    logV(
        'Getting serverside versioning information from RESTful API\nURL: $_url\nRequest headers: $_headers');

    final response = await client.get(
      Uri.parse(_url),
      headers: headers,
    );

    logV('Status code: ${response.statusCode}');
    logV('Response body: ${response.body}');

    // TODO: pretty print the response body

    final json = jsonDecode(response.body);

    return StoreVersioning.fromJson(json);
  }
}
