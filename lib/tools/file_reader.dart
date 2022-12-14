import 'dart:io';
import 'dart:isolate';

class FileReader {
  late final File _file;
  late final Stopwatch _stopwatch;
  late final List<String> _fileLines;

  FileReader() {
    _file = File("file.txt");
    _stopwatch = Stopwatch();
    //reads file by lines
    _fileLines = _file.readAsLinesSync();
  }

  Future<void> computeWithIsolates() async {
    final int length = _fileLines.length;
    _stopwatch.start();
    //isolateNum = 2 gave me the best result
    //spawns # Isolates
    const int isolatesNum = 2; // > 0
    if (isolatesNum <= 0) throw Exception("Isolates number must be at least 1");
    //Ports receive data from Isolates
    List<ReceivePort> portList = [];
    for (int i = 0; i < isolatesNum; i++) {
      portList.add(ReceivePort());
    }
    await _spawnIsolates(portList, isolatesNum);

    //Uses all values from isolates
    int totalChar = await _getSumFromIsolates(portList);
    _stopwatch.stop();
    print(
        "Reading time elapsed: ${_stopwatch.elapsedMilliseconds}\n number of lines within file: $length, \ntotal chars: $totalChar");
  }

  Future<void> _spawnIsolates(List<ReceivePort> rp, int isolatesNum) async {
    int stack = _getStack(isolatesNum);
    for (int i = 0; i < isolatesNum - 1; i++) {
      await Isolate.spawn(
          _heavyWork, ([stack * i, stack * (i + 1), rp[i].sendPort]));
      print("Spawned isolate : $i");
    }
    await Isolate.spawn(
      _heavyWork,
      ([stack * (isolatesNum - 1), _fileLines.length, rp.last.sendPort]),
    );
    print("Spawned last isolate : ${isolatesNum - 1}");
  }

  int _getStack(int isolateNum) {
    int stack = _fileLines.length;
    try {
      // isolateNum > 0
      stack = _fileLines.length ~/ isolateNum;
    } catch (e) {
      //isolateNum==0
      print(e);
    }
    return stack;
  }

  //splits and shuffles all strings in _fileLines using indexes
  //range is : List<int> + [ReceivePort]
  void _heavyWork(List<dynamic> range) {
    SendPort p = range.last;
    range.removeLast();
    //now range is a List<int>
    int ret = 0;
    for (int i = range.first; i < range.last; i++) {
      //random work
      _fileLines[i].split('').shuffle();
      ret += _fileLines[i].length;
    }
    //saves ret in p
    Isolate.exit(p, ret);
  }

  Future<int> _getSumFromIsolates(Iterable<ReceivePort> lp) async {
    int sum = 0;
    for (ReceivePort p in lp) {
      sum += await p.first as int;
    }
    return sum;
  }
}
