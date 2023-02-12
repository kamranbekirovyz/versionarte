import 'package:flutter/material.dart';
import 'package:versionarte/versionarte.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Versionarte Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    Versionarte.check(
      versionarteProvider: RemoteConfigVersionarteProvider(),
    ).then((value) {
      value.status.when(
        couldUpdate: () {},
        mustUpdate: () {},
        unavailable: () {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const VersionarteView.mustUpdate(
      header: FlutterLogo(size: 96.0),
      title: 'App is not available',
      description:
          'We\'re doing some maintainance work on our services. Please, come back later.',
      appleAppId: 123,
      buttonLabel: 'Update the app',
    );
  }
}
