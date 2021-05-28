import 'dart:io';

import 'package:asupan_app/shared/shared.dart';
import 'package:asupan_app/ui/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting().then((_) => runApp(MyApp()));
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Asupan App",
      theme: MyTheme.lightTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        Splash.routeName: (context) => Splash(),
        Frontpage.routeName: (context) => Frontpage(),
        Login.routeName: (context) => Login(),
        Register.routeName: (context) => Register(),
        Datajk.routeName: (context) => Datajk(),
        Databerat.routeName: (context) => Databerat(),
        Bangun.routeName: (context) => Bangun(),
        Tidur.routeName: (context) => Tidur(),
        MainMenu.routeName: (context) => MainMenu(),
        Beranda.routeName: (context) => Beranda(),
        Riwayat.routeName: (context) => Riwayat(),
        Alarm.routeName: (context) => Alarm(),
        Profil.routeName: (context) => Profil(),
        Harian.routeName: (context) => Harian(),
      },
    );
  }
}
