import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:versionarte/src/utilities/logger.dart';
import 'package:versionarte/versionarte.dart';

/// A [VersionarteProvider] that helps retrieve [StoreVersioning] information via
/// sending an HTTP GET request with the given headers to the given URL.
class RestfulVersionarteProvider extends VersionarteProvider {
  /// URL of the RESTful API that returns the [StoreVersioning] information.
  final String url;

  /// Headers to be sent with the HTTP GET request.
  final Map<String, String>? headers;

  /// Creates a new instance of [RestfulVersionarteProvider].
  ///
  /// The [url] parameter is the URL of the RESTful API that returns the [StoreVersioning] information.
  ///
  /// The [headers] parameter allows you to set additional headers to be sent with the HTTP GET request.
  const RestfulVersionarteProvider({
    required this.url,
    this.headers,
  });

  /// Sends an HTTP GET request to the RESTful API and decodes the response body into a [StoreVersioning] object.
  ///
  /// Returns a [Future] that resolves to a [StoreVersioning] object or `null` if there was an
  /// error while sending the HTTP request or decoding the response body.
  @override
  FutureOr<StoreVersioning?> getStoreVersioning() async {
    final client = http.Client();

    logVersionarte('RESTful API URL: $url, Request headers: $headers');

    final response = await client.get(
      Uri.parse(url),
      headers: headers,
    );

    logVersionarte('Status code: ${response.statusCode}');
    logVersionarte('Response body: ${response.body}');

    final json = jsonDecode(response.body);

    // TODO: pretty log response body

    return StoreVersioning.fromJson(json);
  }
}
