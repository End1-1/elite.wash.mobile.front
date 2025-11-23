import 'package:armpet_wash_mobile/router.dart';
import 'package:armpet_wash_mobile/splash_page.dart';
import 'package:armpet_wash_mobile/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SharedPreferences.getInstance();
  if (sp.string('device_id').isEmpty) {
    sp.setString('device_id', await getDeviceName());
  }
  await Hive.initFlutter();
  await Hive.openBox('myBox');
  runApp( App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elite',
      onGenerateTitle: (context) => AppLocalizations.of(context)!.title,
      navigatorKey: navigatorKey,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('hy'), // Spanish
      ],
      locale: Locale('hy'),
      onGenerateRoute: generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashPage(),
    );
  }
}

