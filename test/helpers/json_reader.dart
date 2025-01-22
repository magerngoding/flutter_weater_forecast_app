import 'dart:io';

String readJson(String fileName) {
  final path = '${Directory.current.path}/test/helpers/dummy_data/$fileName';

  return File(path).readAsStringSync();
}
