// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// CliGenerator
// **************************************************************************

Config _$parseConfigResult(ArgResults result) => Config(
      apkname: result['apkname'] as String,
      cleanall: result['cleanall'] as bool?,
      cleanexceptlast: result['cleanexceptlast'] as bool?,
      storeName: result['store-name'] as String?,
    );

ArgParser _$populateConfigParser(ArgParser parser) => parser
  ..addOption(
    'apkname',
    abbr: 'n',
    help: 'The name of APK file to upload',
    defaultsTo: 'app-prod-release',
  )
  ..addFlag(
    'cleanall',
    abbr: 'D',
    help: 'Delete all the APK uploaded till date',
    defaultsTo: null,
  )
  ..addFlag(
    'cleanexceptlast',
    abbr: 'd',
    help: 'Delete all the APK uploaded till date except the last one',
    defaultsTo: null,
  )
  ..addOption(
    'store-name',
    abbr: 'o',
    help: 'The name of the apk to store as',
  );

final _$parserForConfig = _$populateConfigParser(ArgParser());

Config parseConfig(List<String> args) {
  final result = _$parserForConfig.parse(args);
  return _$parseConfigResult(result);
}
