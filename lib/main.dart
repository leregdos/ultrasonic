import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';

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
  FlutterAudioRecorder2 recorder =
      FlutterAudioRecorder2("recording1", audioFormat: AudioFormat.WAV);
  bool _recording = false;

  Future<bool> hasPermission() async {
    bool? hasPermission = await FlutterAudioRecorder2.hasPermissions;
    return hasPermission!;
  }

  record() async {
    var recording = await recorder.current(channel: 0);
    if (_recording) {
      if (recording != null) {
        if (recording.status == RecordingStatus.Paused) {
          await recorder.resume();
        } else {
          await recorder.start();
        }
        print(recording.status);
      }
    } else {
      await recorder.pause();
      if (recording != null) {
        print(recording.status);
      }
    }
  }

  void _recordStop() async {
    bool perm = await hasPermission();
    if (perm) {
      setState(() {
        _recording = !_recording;
      });
      record();
    }
  }

  void _save() async {
    bool perm = await hasPermission();
    if (perm) {
      if (_recording) {
        setState(() {
          _recording = false;
        });
        recorder.stop();
      }
    }
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
            const SizedBox(
              height: 30,
            ),
            Card(
              color: Colors.grey,
              elevation: 20,
              borderOnForeground: true,
              child: MaterialButton(
                onPressed: _save,
                child: Text('Save Recording',
                    style: Theme.of(context).textTheme.headline6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
