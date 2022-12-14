import 'dart:io';
import 'package:deep_focus/tools/file_reader.dart';

import '../lib/tools/file_writer.dart';

void main(List<String> arguments) async {
  //Creates a new file called "file.txt" in the current directory
  final ft = FileWriter();
  //Writes some strings inside this new file
  await ft.start();
  //Reads the file
  final fr = FileReader();
  //Computes a heavy work using isolates
  await fr.computeWithIsolates();
  exit(0);
}
