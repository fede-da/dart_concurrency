import 'package:thread/thread.dart';

Future<int> calculate() async {
  final thread = Thread((events) {
    events.on('data', (String data) async {
      await Future.delayed(const Duration(seconds: 1));
      events.emit('result', '<Computed> $data');
    });
  });

  thread.on('result', (String data) => print(data));

  thread.emit('data', 'Hello world!');
  thread.emit('data', 'Wow!');
  thread.emit('end', true);

  //print(await thread.compute(() => 'Hello world!'));
  //print(await thread.computeWith(123, (int data) => 'Wow $data'));
  //throw Exception("End thread");

  // [Output]
  // Hello world!
  // Wow 123

  // <Computed> Hello world!
  // <Computed> Wow!
  //await Future.delayed(Duration(seconds: 3));
  return 6 * 7;
}
