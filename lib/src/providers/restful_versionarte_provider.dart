import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:versionarte/src/models/versionarte_comparator.dart';
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

    /// The line `VersionarteComparator comparator = VersionarteComparator.versionOnly,` in the
    /// `RestfulVersionarteProvider` class is defining a parameter `comparator` of type
    /// `VersionarteComparator` with a default value of `VersionarteComparator.versionOnly`.
    VersionarteComparator comparator = VersionarteComparator.versionOnly,
  }) : super(comparator: comparator);

  /// Sends an HTTP GET request to the RESTful API and decodes the response body into a [DistributionManifest] object.
  ///
  /// Returns a [Future] that resolves to a [DistributionManifest] object or `null` if there was an
  /// error while sending the HTTP request or decoding the response body.
  @override
  FutureOr<DistributionManifest?> getDistributionManifest() async {
    final client = http.Client();

    logVersionarte('RESTful API URL: $url, Request headers: $headers');

    final response = await client.get(
      Uri.parse(url),
      headers: headers,
    );

    logVersionarte('Status code: ${response.statusCode}');
    logVersionarte('Response body: ${response.body}');

    final json = jsonDecode(response.body);

    return DistributionManifest.fromJson(json);
  }
}
