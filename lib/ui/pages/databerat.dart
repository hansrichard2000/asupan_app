part of 'pages.dart';

class Databerat extends StatefulWidget {
  static const String routeName = "/databerat";
  @override
  _DataberatState createState() => _DataberatState();
}

class _DataberatState extends State<Databerat> {
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
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: size.height / 1.7,
                ),
                Container(
                  width: double.infinity,
                  child: Image(
                    image: AssetImage("assets/images/texture3.png"),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 50, 0, 10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              color: Color(0xFF0057FF),
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(10)),
                          width: 80,
                          height: 25,
                          margin: EdgeInsets.all(5),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(10)),
                          width: 80,
                          height: 25,
                          margin: EdgeInsets.all(5),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(10)),
                          width: 80,
                          height: 25,
                          margin: EdgeInsets.all(5),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(10)),
                          width: 80,
                          height: 25,
                          margin: EdgeInsets.all(5),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      child: Text("Berat Anda",
                          style: TextStyle(fontSize: 36, color: Colors.white)))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
