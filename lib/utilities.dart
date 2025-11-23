import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'l10n/app_localizations.dart';

late final SharedPreferences sp;

extension Prefs on SharedPreferences {
  String string(String key) {
    return getString(key) ?? '';
  }

  String df(String v) {
    return v.contains('.') || v.contains(',')
        ? v
        .replaceAll(RegExp(r'(?!\d[\.,][1-9]+)0+$'), '')
        .replaceAll(RegExp(r'[\.,]$'), '')
        : v;
  }


}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

tr() {
  return AppLocalizations.of(navigatorKey.currentContext!)!;
}

Future<String> getDeviceName() async {
  final deviceInfo = DeviceInfoPlugin();

  final dn = Uuid().v4();
  if (Platform.isAndroid) {
    final info = await deviceInfo.androidInfo;
    return "${info.manufacturer} ${info.model} $dn";
  } else if (Platform.isIOS) {
    final info = await deviceInfo.iosInfo;
    return "${info.name} ${info.model} $dn";
  } else if (Platform.isWindows) {
    final info = await deviceInfo.windowsInfo;
    return "Windows ${info.computerName} $dn";
  } else if (Platform.isLinux) {
    final info = await deviceInfo.linuxInfo;
    return "${info.name ?? "Linux"}  $dn";
  } else if (Platform.isMacOS) {
    final info = await deviceInfo.macOsInfo;
    return "${info.computerName} $dn";
  } else {
    return "$dn Unknown device";
  }
}

Future<void> showLoadingDialog({String? message}) async {
  final ctx = navigatorKey.currentContext;
  if (ctx == null) return;

  showDialog(
    context: ctx,
    barrierDismissible: false,
    builder:
        (_) => PopScope(
          canPop: false,
          child: AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 16),
                Expanded(child: Text(message ?? tr().loading)),
              ],
            ),
          ),
        ),
  );
}

void hideDialog() {
  navigatorKey.currentState?.pop();
}

void showErrorDialog(String message) {
  final ctx = navigatorKey.currentContext;
  if (ctx == null) return;

  showDialog(
    context: ctx,
    builder:
        (_) => AlertDialog(
          title: Text(tr().error),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => navigatorKey.currentState?.pop(),
              child: Text(tr().ok),
            ),
          ],
        ),
  );
}

Future<bool> showConfirmDialog(BuildContext context, String message) async {
  final result = await showDialog<bool>(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text(tr().confirmation),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(tr().no),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(tr().yes),
            ),
          ],
        ),
  );
  return result ?? false;
}

Widget textFormField(TextEditingController controller, String title) {
  return Expanded(child: TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: title,
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
    ),
  ));
}
