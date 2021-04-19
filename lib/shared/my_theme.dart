part of 'shared.dart';

class MyTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Color(0xFF0057FF),
      accentColor: Color(0xFF2F80ED),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      fontFamily: 'Sansation',
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      backgroundColor: Color(0xFF0057FF),
      scaffoldBackgroundColor: Color(0xFF0057FF),
      primaryColor: Color(0xFF0057FF),
      accentColor: Color(0xFF2F80ED),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
    );
  }
}
