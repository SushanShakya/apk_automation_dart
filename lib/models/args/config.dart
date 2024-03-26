// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:build_cli_annotations/build_cli_annotations.dart';

part 'config.g.dart';

@CliOptions()
class Config {
  @CliOption(
    abbr: "n",
    help: "The name of APK file to upload",
    defaultsTo: "app-prod-release",
  )
  final String apkname;

  @CliOption(abbr: "D", help: "Delete all the APK uploaded till date")
  final bool? cleanall;

  @CliOption(
    abbr: "d",
    help: "Delete all the APK uploaded till date except the last one",
  )
  final bool? cleanexceptlast;

  @CliOption(
    abbr: "o",
    help: "The name of the apk to store as",
  )
  final String? storeName;

  Config({
    required this.apkname,
    this.cleanall,
    this.cleanexceptlast,
    this.storeName,
  });

  @override
  String toString() {
    return 'Config(apkname: $apkname, cleanall: $cleanall, cleanexceptlast: $cleanexceptlast, storeName: $storeName)';
  }
}
