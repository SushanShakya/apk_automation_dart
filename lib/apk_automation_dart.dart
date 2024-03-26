import 'package:advanced_console/advanced_console.dart';
import 'package:apk_automation_dart/extensions/date_extension.dart';
import 'package:apk_automation_dart/models/args/config.dart';
import 'package:cli_spin/cli_spin.dart';

import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/drive/v2.dart' as drive;

import 'dart:convert';
import 'dart:io';

final scopes = [drive.DriveApi.driveScope];

Future<String> getApiKey() async {
  var input = await File("apikey.json").readAsString();
  var map = jsonDecode(input);
  return map['key'];
}

Future<Map<String, dynamic>> getAppCreds() async {
  var input = await File("credentials.json").readAsString();
  var map = jsonDecode(input);
  return map['installed'];
}

Future<drive.File> uploadFile(
  drive.DriveApi api,
  String file,
  String name,
) async {
  // We create a `Media` object with a `Stream` of bytes and the length of the
  // file. This media object is passed to the API call via `uploadMedia`.
  // We pass a partially filled-in `drive.File` object with the title we want
  // to give our newly created file.
  var localFile = File(file);
  var media = drive.Media(localFile.openRead(), localFile.lengthSync());
  var driveFile = drive.File()..title = "$name.apk";
  final f = await api.files.insert(driveFile, uploadMedia: media);
  return f;
}

Future<auth.ClientId> getClientId() async {
  final appConfig = await getAppCreds();

  final clientId = appConfig['client_id'];
  final clientSecret = appConfig['client_secret'];

  return auth.ClientId(
    clientId,
    clientSecret,
  );
}

Future<drive.DriveApi> getApi() async {
  final identifier = await getClientId();

// This is the list of scopes this application will use.
// You need to enable the Drive API in the Google Developers Console.

  // var apiKey = await getApiKey();

  var client = await auth.clientViaUserConsent(
    identifier,
    scopes,
    (String url) {
      print("Please go to the following URL and grant access:");
      print(green(url));
      print("");
    },
  );
  // var client = auth.clientViaApiKey(apiKey);

  return drive.DriveApi(client);
}

Future<void> uploadToDrive(Config config) async {
  final defaultOutputName = DateTime.now().stringify;

  final api = await getApi();

  var filePath = "./build/app/outputs/flutter-apk/${config.apkname}.apk";

  var spinner = CliSpin(
    text: 'Uploading File...',
    spinner: CliSpinners.dots,
    color: CliSpinnerColor.cyan,
  )..start();

  final uploadedFile = await uploadFile(
    api,
    filePath,
    config.storeName ?? defaultOutputName,
  );

  spinner.stop();

  print(
    green(
      "https://drive.google.com/file/d/${uploadedFile.id}/view?usp=sharing",
    ),
  );
}
