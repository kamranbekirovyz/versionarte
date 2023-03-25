import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:versionarte/src/utilities/logger.dart';
import 'package:versionarte/versionarte.dart';

/// A [VersionarteProvider] that helps retrieve `StoreVersioning` information via
/// sending an HTTP GET request with the given headers to the given URL.
class RestfulVersionarteProvider extends VersionarteProvider {
  final String _url;
  final Map<String, String>? _headers;

  /// Creates a new instance of [RestfulVersionarteProvider].
  ///
  /// The `url` parameter is the URL of the RESTful API that returns the StoreVersioning information.
  ///
  /// The `headers` parameter allows you to set additional headers to be sent with the HTTP GET request.
  const RestfulVersionarteProvider({
    required String url,
    Map<String, String>? headers,
  })  : _url = url,
        _headers = headers;

  /// Sends an HTTP GET request to the RESTful API and decodes the response body into a `StoreVersioning` object.
  ///
  /// Returns a [Future] that resolves to a `StoreVersioning` object or `null` if there was an
  /// error while sending the HTTP request or decoding the response body.
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

    logVersionarte('RESTful API URL: $_url, Request headers: $_headers');

    final response = await client.get(
      Uri.parse(_url),
      headers: headers,
    );

    logVersionarte('Status code: ${response.statusCode}');
    logVersionarte('Response body: ${response.body}');

    final json = jsonDecode(response.body);

    // TODO: pretty log response body

    return StoreVersioning.fromJson(json);
  }
}
