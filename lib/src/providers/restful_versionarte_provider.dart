import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:versionarte/src/utilities/logger.dart';
import 'package:versionarte/versionarte.dart';

/// A [VersionarteProvider] that helps retrieve [DistributionManifest] information via
/// sending an HTTP GET request with the given headers to the given URL.
class RestfulVersionarteProvider extends VersionarteProvider {
  /// URL of the RESTful API that returns the [DistributionManifest] information.
  final String url;

  /// Headers to be sent with the HTTP GET request.
  final Map<String, String>? headers;

  /// Creates a new instance of [RestfulVersionarteProvider].
  ///
  /// The [url] parameter is the URL of the RESTful API that returns the [DistributionManifest] information.
  ///
  /// The [headers] parameter allows you to set additional headers to be sent with the HTTP GET request.
  const RestfulVersionarteProvider({
    required this.url,
    this.headers,
  });

  /// Sends an HTTP GET request to the RESTful API and decodes the response body into a [DistributionManifest] object.
  ///
  /// Returns a [Future] that resolves to a [DistributionManifest] object or `null` if there was an
  /// error while sending the HTTP request or decoding the response body.
  @override
  FutureOr<DistributionManifest?> getDistributionManifest() async {
    final client = http.Client();

    final cacheBustedUrl = _appendTimestamp(url);
    logVersionarte('RESTful API URL: $cacheBustedUrl, Request headers: $headers');
    debugPrint('RESTful API URL: $cacheBustedUrl, Request headers: $headers');
    final response = await client.get(
      Uri.parse(cacheBustedUrl),
      headers: {
        ...?headers,
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
      },
    );

    logVersionarte('Status code: ${response.statusCode}');
    logVersionarte('Response body: ${response.body}');

    return compute(_parseDistributionManifest, response.body);
  }
}

DistributionManifest _parseDistributionManifest(String data) {
  final json = jsonDecode(data);
  return DistributionManifest.fromJson(json);
}
/// Appends a timestamp query parameter to the given URL
String _appendTimestamp(String baseUrl) {
  final uri = Uri.parse(baseUrl);
  final updatedParams = Map<String, String>.from(uri.queryParameters)
    ..['t'] = DateTime.now().millisecondsSinceEpoch.toString();
  return uri.replace(queryParameters: updatedParams).toString();
}