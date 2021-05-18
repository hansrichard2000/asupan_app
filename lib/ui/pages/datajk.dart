part of 'pages.dart';

class Datajk extends StatefulWidget {
  static const String routeName = "/datajk";
  @override
  _DatajkState createState() => _DatajkState();
}

class _DatajkState extends State<Datajk> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonSize = size.width / 5;
    bool buttonMale = false;
    bool buttonFemale = false;
    bool male = false;
    bool female = false;
    bool isVisible = true;
    bool isLoading = false;
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
                      child: Text("Jenis Kelamin",
                          style: TextStyle(fontSize: 36, color: Colors.white))),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ClipOval(
                          child: Material(
                            color: buttonMale
                                ? Colors.blue[700]
                                : Colors.white, // button color
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  male = true;
                                  female = false;
                                  isLoading = true;
                                  buttonMale = true;
                                  buttonFemale = false;
                                });
                                Stats stats = Stats(
                                  "",
                                  FirebaseAuth.instance.currentUser.uid,
                                  "L",
                                  0,
                                  0,
                                  0,
                                  "",
                                  "",
                                  "",
                                  "",
                                  "",
                                  "",
                                );
                                await StatsServices.addJenisKelamin(stats).then(
                                    (value) => ActivityServices.showToast(
                                        "Laki-Laki", Colors.blueAccent[700]));
                                // isLoading = false;Z
                                Navigator.pushReplacementNamed(
                                    context, Databerat.routeName);
                              },
                              splashColor: buttonMale
                                  ? Colors.white
                                  : Colors.blue[700], // inkwell color
                              child: SizedBox(
                                  width: size.width / 4,
                                  height: size.height / 6.5,
                                  child: Icon(
                                    MdiIcons.humanMale,
                                    size: buttonSize,
                                  )),
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: buttonFemale
                                ? Colors.red[200]
                                : Colors.white, // button color
                            child: InkWell(
                              splashColor: buttonFemale
                                  ? Colors.white
                                  : Colors.red[200], // inkwell color
                              child: SizedBox(
                                  width: size.width / 4,
                                  height: size.height / 6.5,
                                  child: Icon(
                                    MdiIcons.humanFemale,
                                    size: buttonSize,
                                  )),
                              onTap: () async {
                                setState(() {
                                  male = false;
                                  female = true;
                                  buttonFemale = true;
                                  buttonMale = false;
                                });
                                Stats stats = Stats(
                                  "",
                                  FirebaseAuth.instance.currentUser.uid,
                                  "P",
                                  0,
                                  0,
                                  0,
                                  "",
                                  "",
                                  "",
                                  "",
                                  "",
                                  "",
                                );
                                await StatsServices.addJenisKelamin(stats).then(
                                    (value) => ActivityServices.showToast(
                                        "Perempuan", Colors.red[200]));
                                Navigator.pushReplacementNamed(
                                    context, Databerat.routeName);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height / 4,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ClipOval(
                          child: Material(
                            color: Colors.white60, // button color
                            child: InkWell(
                              child: SizedBox(
                                  width: size.width / 5,
                                  height: size.height / 8.5,
                                  child: Icon(
                                    Icons.arrow_left,
                                    size: buttonSize,
                                  )),
                              onTap: null,
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: Colors.white, // button color
                            child: InkWell(
                              splashColor:
                                  Colors.blueAccent[700], // inkwell color
                              child: SizedBox(
                                  width: size.width / 5,
                                  height: size.height / 8.5,
                                  child: Icon(
                                    Icons.arrow_right,
                                    size: buttonSize,
                                  )),
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, Databerat.routeName);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isLoading == true ? ActivityServices.loadings() : Container()
          ],
        ),
      ),
    );
  }
}
