import 'dart:async';

class StringGenerator {
  String str = 'Ciao, sono una stringa generata random!\n';
  final _controller = StreamController<String>();

  void startGenerate() {
    Timer.periodic(Duration(seconds: 1), (t) {
      _controller.sink.add(str);
      //print("string added to sink");
    });
  }

  Stream<String> get stream => _controller.stream;
}
