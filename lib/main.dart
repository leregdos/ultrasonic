import 'package:flutter/material.dart';
// import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ultrasonic Sensor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Check for Ultrasonic Beacons'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _recording = false;
  // bool hasPermission = await FlutterAudioRecorder2.hasPermissions;

  void _recordStop() {
    setState(() {
      _recording = !_recording;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _recording ? 'Stop recording' : 'Record Audio',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 30,
            ),
            FloatingActionButton(
              onPressed: _recordStop,
              tooltip: 'Record',
              child:
                  _recording ? Icon(Icons.stop) : Icon(Icons.record_voice_over),
            ),
          ],
        ),
      ),
    );
  }
}
