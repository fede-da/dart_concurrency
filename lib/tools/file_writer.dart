import 'dart:async';
import 'dart:io';

// import 'package:path_provider/path_provider.dart';

import 'generator.dart';

class FileWriter {
  late final File _file;
  late final StringGenerator _st;
  late final IOSink _sink;
  late final StreamSubscription<String> _sub;

  FileWriter() {
    _file = File('file.txt');
    //_st writes strings inside sink
    _st = StringGenerator();
    //sink writes inside file.txt
    _sink = _file.openWrite();
  }

  Future<void> start() async {
    //_sub starts listening to new incoming events within sink
    _sub = _getSub();
    _st.startGenerate();
    await automaticStop();
  }

  StreamSubscription<String> _getSub() {
    //When a new event is caught
    return _st.stream.listen((event) {
      //then write many strings inside file.txt
      _sink.write('$event$event'
          '$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event'
          '$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event'
          '$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event'
          '$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event'
          '$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event'
          '$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event'
          '$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event'
          '$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event'
          '$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event'
          '$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event$event');
    });
  }

  Future<void> automaticStop() async {
    //writing process lasts 6 seconds
    await Future.delayed(Duration(seconds: 6), () {
      _stopSub();
      _closeSink();
    });
  }

  Future<void> _closeSink() async {
    await _sink.flush();
    await _sink.close();
    return;
  }

  File getFile() => _file;

  //Stops listening to new events
  void _stopSub() {
    _sub.cancel();
  }

  void resumeSub() => _sub.resume();
}
