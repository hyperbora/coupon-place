import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

Future<String> saveImage(File imageFile) async {
  final directory = await getApplicationDocumentsDirectory();
  final ext = p.extension(imageFile.path);
  final filePath = '${directory.path}/${const Uuid().v4()}$ext';
  final savedImage = await imageFile.copy(filePath);
  return savedImage.path;
}
