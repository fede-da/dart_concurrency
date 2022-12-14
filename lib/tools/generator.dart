import 'dart:async';

class StringGenerator {
  static const String str = "Hi! Has Rufy's crew found the One Piece? \n";
  final _controller = StreamController<String>();

  void startGenerate() {
    print(
        "I'm copying this sentence many times into the file, be patient:\n$str");
    Timer.periodic(Duration(milliseconds: 1), (t) {
      //puts data inside inside the stream (events)
      _controller.sink.add(str);
    });
  }

  Stream<String> get stream => _controller.stream;
}
