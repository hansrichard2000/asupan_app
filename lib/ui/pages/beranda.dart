part of 'pages.dart';

class Beranda extends StatefulWidget {
  static const String routeName = "/beranda";
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF0057FF),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xFFFFFF), Color(0xFF0085FF)],
                tileMode: TileMode.repeated)),
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(30, 60, 0, 0),
              child: Text("Halo",
                  style: TextStyle(
                    fontFamily: "Sansation",
                    fontSize: 30,
                    color: Colors.white,
                  )),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
