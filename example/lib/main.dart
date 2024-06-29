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
      themeMode: ThemeMode.light,
      home: MyHomePage(),
    );
  }
}

/// This is a mock class that implements the VersionarteProvider interface not
/// intended for real use, but only for the example. Most of the time you will
/// use [RemoteConfigVersionarteProvider] or [RestfulVersionarteProvider] with
/// remotely stored dynamic values.
class MockVersionarteProvider extends VersionarteProvider {
  @override
  Future<StoreVersioning?> getStoreVersioning() async {
    await Future.delayed(const Duration(seconds: 2));

    /// Creating a mocked [StoreVersioning] object with the following values:
    const mockedStoreVersioning = StoreVersioning(
      android: StorePlatformDetails(
        downloadUrl: 'https://play.google.com',
        version: VersionDetails(
          minimum: '1.5.0',
          latest: '2.5.0',
        ),
        status: StatusDetails(
          active: true,
          message: {
            'en': 'This is a message in English',
            'es': 'Este es un mensaje en español',
          },
        ),
      ),
      iOS: StorePlatformDetails(
        downloadUrl: 'https://apps.apple.com/us/',
        version: VersionDetails(
          minimum: '1.5.0',
          latest: '2.5.0',
        ),
        status: StatusDetails(
          active: true,
          message: {
            'en': 'This is a message in English',
            'es': 'Este es un mensaje en español',
          },
        ),
      ),
    );

    return mockedStoreVersioning;
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
    setState(() => _isChecking = true);

    _versionarteResult = await Versionarte.check(
      versionarteProvider: MockVersionarteProvider(),
    );

    setState(() => _isChecking = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Versionarte Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isChecking)
            const Center(
              child: CircularProgressIndicator(),
            )
          else ...[
            ListTile(
              title: const Text('Result'),
              subtitle: Text(_versionarteResult.status.toString()),
            ),
            const ListTile(
              title: Text('Local version'),
              subtitle: Text('1.0.0'),
            ),
            ListTile(
              title: const Text('Store version'),
              subtitle: Text(
                '${_versionarteResult.details?.version.toString()}',
              ),
            ),
            ListTile(
              title: const Text('Download URL'),
              subtitle: Text(
                '${_versionarteResult.details?.downloadUrl.toString()}',
              ),
            ),
            ListTile(
              title: const Text('Status'),
              subtitle: Text(_versionarteResult.status.toString()),
            ),
            ListTile(
              title: const Text('Availability information'),
              subtitle: Text(
                '${_versionarteResult.details?.status.toString()}',
              ),
            ),

            /// This is an example of how to get a message for a specific language.
            ListTile(
              title: const Text('Message for English'),
              subtitle: Text(
                '${_versionarteResult.details?.status.getMessageForLanguage('en')}',
              ),
            ),
          ],
        ],
      ),
    );
  }
}
