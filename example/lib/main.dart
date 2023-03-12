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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Versionarte Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final VersionarteResult _versionarteResult;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();

    _checkVersionarte();
  }

  Future<void> _checkVersionarte() async {
    setState(() {
      _isChecking = true;
    });

    _versionarteResult = await Versionarte.check(
      versionarteProvider: RemoteConfigVersionarteProvider(),
      localVersioning: const LocalVersioning(
        androidVersionNumber: _androidVersion,
        iOSVersionNumber: _iosVersion,
      ),
    );

    setState(() {
      _isChecking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Versionarte Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isChecking)
              const CircularProgressIndicator()
            else ...[
              ListTile(
                title: const Text('Status'),
                subtitle: Text(
                  _versionarteResult.status.toString(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
