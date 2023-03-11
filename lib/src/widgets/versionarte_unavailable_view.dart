import 'package:flutter/material.dart';
import 'package:versionarte/src/widgets/_versionarte_base_view.dart';
import 'package:versionarte/versionarte.dart';

class VersionarteUnavailableView extends StatelessWidget {
  /// Widget to be displayed at the top of the page.
  final Widget? header;

  ///
  final UnavailabilityText? unavailabilityText;

  /// View can be used to show user when status is [VersionarteStatus.mustUpdate]
  const VersionarteUnavailableView({
    Key? key,
    required this.unavailabilityText,
    this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VersionarteBaseView(
      title: unavailabilityText?.message ?? '',
      description: unavailabilityText?.details ?? '',
      header: header,
    );
  }
}
