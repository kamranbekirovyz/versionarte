import 'package:flutter/material.dart';
import 'package:versionarte/versionarte.dart';

const _androidVersion = 3;
const _iosVersion = 3;

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
  VersionarteResult? _versionarteResult;

  @override
  void initState() {
    super.initState();

    _checkVersionarte();
  }

  Future<void> _checkVersionarte() async {
    _versionarteResult = await Versionarte.check(
      versionarteProvider: RemoteConfigVersionarteProvider(),
      localVersioning: const LocalVersioning(
        androidVersion: _androidVersion,
        iosVersion: _iosVersion,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Versionarte Demo'),
      ),
      body: _versionarteResult == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : const VersionarteView.mustUpdate(
              header: FlutterLogo(size: 96.0),
              title: 'App is not available',
              description:
                  'We\'re doing some maintainance work on our services. Please, come back later.',
              appleAppId: 123,
              buttonLabel: 'Update the app',
            ),
    );
  }
}
