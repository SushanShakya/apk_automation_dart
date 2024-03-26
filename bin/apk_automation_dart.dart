import 'package:apk_automation_dart/apk_automation_dart.dart'
    as apk_automation_dart;
import 'package:apk_automation_dart/models/args/config.dart';

void main(List<String> args) async {
  final config = parseConfig(args);
  await apk_automation_dart.uploadToDrive(config);
}
