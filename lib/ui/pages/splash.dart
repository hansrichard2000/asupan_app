part of 'pages.dart';

class Splash extends StatefulWidget {
  static const String routeName = "/splash";
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String userName;
  @override
  void initState() {
    super.initState();
    _loadSplash();
  }

  _loadSplash() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, checkAuth);
  }

  // Future<String> _getUserName() async {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(await FirebaseAuth.instance.currentUser.uid)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       userName = value.data()['name'].toString();
  //     });
  //   });
  //   return userName;
  // }

  void checkAuth() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      String uid = FirebaseAuth.instance.currentUser.uid;
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection("users");
      // userName = await _getUserName();
      Navigator.pushReplacementNamed(context, MainMenu.routeName);
      ActivityServices.showToast(
          "Welcome Back " + auth.currentUser.email, Colors.blueAccent[700]);
    } else {
      Navigator.pushReplacementNamed(context, Frontpage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Color(0xFF0057FF)),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Color(0xFF0085FF), Color(0xFFFFFF)],
                      tileMode: TileMode.repeated)),
            ),
            Column(
              children: [
                SizedBox(
                  height: size.height / 6,
                ),
                Flexible(
                  flex: 2,
                  child: Image(
                    image: AssetImage("assets/images/logoasupan.png"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 30, 30, 10),
                  child: Text("ASUPAN",
                      style: TextStyle(fontSize: 36, color: Colors.white)),
                  alignment: Alignment.center,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: RichText(
                    text: TextSpan(
                        text: "Minum Air Jadi Kebiasaan",
                        style:
                            TextStyle(fontFamily: "Sansation", fontSize: 18)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Image(
                    image: AssetImage("assets/images/texture3.png"),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
