import 'package:flutter/material.dart';
import 'package:flutter_artkit/flutter_artkit.dart';
import 'package:versionarte/versionarte.dart';

class VersionarteInactiveView extends StatelessWidget {
  final String? title;
  final String? description;
  final Widget? header;

  const VersionarteInactiveView({
    Key? key,
    this.title,
    this.description,
    this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DarkStatusbar(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          if (header != null) ...[
            header!,
            const Hoxy(64.0),
          ],
          Text(
            title.asValidString(),
            textAlign: TextAlign.center,
            style: context.textTheme.headlineMedium?.withColor(Colors.black),
          ),
          const Hoxy(24.0),
          Text(
            description.asValidString(),
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge?.withColor(Colors.black87),
          ),
          const Spacer(),
          const VersionarteIndicator(),
          const BottomPadding(),
        ],
      ),
    );
  }
}
