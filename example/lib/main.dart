import 'package:flutter/material.dart';
import 'package:versionarte/versionarte.dart';

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

class MockVersionarteProvider extends VersionarteProvider {
  @override
  Future<StoreVersioning?> getStoreVersioning() async {
    await Future.delayed(const Duration(seconds: 2));
    final mockResponse = {
      "android": {
        "minimum": "2.7.1",
        "latest": "2.8.0",
        "active": true,
        "message": {
          "en": "App is in maintanence mode, please come back later.",
          "es": "La aplicación está en modo de mantenimiento, vuelva más tarde.",
        }
      },
      "ios": {
        "minimum": "1.1.1",
        "latest": "1.2.1",
        "active": false,
        "message": {
          "en": "App is in maintanence mode, please come back later.",
          "es": "La aplicación está en modo de mantenimiento, vuelva más tarde.",
        }
      }
    };

    return StoreVersioning.fromJson(mockResponse);
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
      versionarteProvider: MockVersionarteProvider(),
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
