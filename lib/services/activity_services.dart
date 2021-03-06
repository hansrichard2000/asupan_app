part of 'services.dart';

class ActivityServices {
  static String dateNow() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    String hasil = formatter.format(now);
    return hasil;
  }

  static String dateToday() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String hasil = formatter.format(now);
    return hasil;
  }

  static String dateTodayIndo() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String hasil = formatter.format(now);
    return hasil;
  }

  static String timeToday() {
    var now = new DateTime.now();
    var formatter = new DateFormat('HH:mm');
    String hasil = formatter.format(now);
    return hasil;
  }

  static void showToast(String text, Color mycolor) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: mycolor,
      textColor: Colors.white,
      fontSize: 14,
    );
  }

  static Container loadings() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Colors.black26,
      child: SpinKitFadingCircle(
        size: 50,
        color: Color(0xFF0057FF),
      ),
    );
  }
}
