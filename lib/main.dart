import 'package:asupan_app/shared/shared.dart';
import 'package:asupan_app/ui/pages/pages.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
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
        '/': (context) => Datajk(),
        Frontpage.routeName: (context) => Frontpage(),
        Login.routeName: (context) => Login(),
        Register.routeName: (context) => Register(),
        Datajk.routeName: (context) => Datajk(),
        Datatinggi.routeName: (context) => Datatinggi(),
        Databerat.routeName: (context) => Databerat(),
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
