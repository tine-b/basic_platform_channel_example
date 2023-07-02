import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Basic Platform Channels'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('sampleChannel');
  String _status = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Charging Status:'),
            Text(
              _status.isNotEmpty ? _status : 'N/A',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: () {
                _getChargingStatus();
              },
              icon: const Icon(Icons.battery_std),
              label: const Text('Get Battery Level'),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _getChargingStatus() async {
    try {
      final String? result = await platform.invokeMethod('isCharging');
      setState(() {
        _status = result ?? '';
      });
    } catch (_) {
      debugPrint('[ERROR] Fetching of charging status unsuccessful');
    }
  }
}
