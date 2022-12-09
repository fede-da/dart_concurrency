import 'dart:async';
import 'dart:io';

// import 'package:path_provider/path_provider.dart';

import 'generator.dart';

class FileTool {
  late final File file;
  late final StringGenerator st;
  late final IOSink sink;
  late final Stream<List<int>> stream;

  FileTool() {
    file = File('file.txt');
    file.writeAsString("Hello!\n");
    st = StringGenerator();
    st.startGenerate();
    sink = file.openWrite();
    stream = file.openRead();
  }

  void writeOn() {
    st.stream.listen((event) {
      //file.writeAsString(event, mode: FileMode.append);
      sink.write(event);
    });
  }

  void readFrom() async {
    await Future.delayed(Duration(seconds: 4));
    file.readAsString().then((value) {
      print(value);
    });
    stream.listen(
      (event) {
        print(event);
      },
      onError: (e) {
        print(e);
      },
      onDone: () {
        print("Reading completed!");
      },
    );
  }

  void closeFile() {
    sink.close();
  }
}
