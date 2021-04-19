part of 'pages.dart';

class Frontpage extends StatefulWidget {
  static const String routeName = "/frontpage";
  @override
  _FrontpageState createState() => _FrontpageState();
}

class _FrontpageState extends State<Frontpage> {
  @override
  Widget build(BuildContext context) {
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
                Flexible(
                  flex: 2,
                  child: Image(
                    image: AssetImage("assets/images/texture3.png"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 30, 30, 10),
                  child: Text("ASUPAN",
                      style: TextStyle(fontSize: 36, color: Colors.white)),
                  alignment: Alignment.centerLeft,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: RichText(
                    text: TextSpan(
                        text:
                            "Asupan akan membantu kamu mengingat dan mencatat aktivitas minum air kamu",
                        style:
                            TextStyle(fontFamily: "Sansation", fontSize: 18)),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Image(
                    image: AssetImage("assets/images/texture3.png"),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 80),
              child: Column(
                children: [
                  Expanded(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                  )),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Login.routeName);
                      },
                      child: Text(
                        "MASUK",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Sansation",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0057FF),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          primary: Colors.white,
                          elevation: 4,
                          padding: EdgeInsets.fromLTRB(70, 5, 70, 5)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Register.routeName);
                    },
                    child: Text(
                      "DAFTAR",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Sansation",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0057FF),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        primary: Colors.white,
                        elevation: 4,
                        padding: EdgeInsets.fromLTRB(70, 5, 70, 5)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
