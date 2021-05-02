part of 'pages.dart';

class Riwayat extends StatefulWidget {
  static const String routeName = "/riwayat";
  @override
  _RiwayatState createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Color(0xFFf1fcff),
          title: Text(
            "Statistik Minum",
            style: TextStyle(
              fontFamily: "Sansation",
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: Color(0xFFf1fcff),
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height / 2.3,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  color: Color(0xFF0057FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color(0xFF0085FF),
                                Color(0xFFFFFF)
                              ],
                              tileMode: TileMode.repeated)),
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: ElevatedButton(
                                onPressed: () async {},
                                child: Text(
                                  "Minggu ini",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Sansation",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    primary: Color(0xFF0057FF),
                                    elevation: 4,
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: ElevatedButton(
                                onPressed: () async {},
                                child: Text(
                                  "Bulan ini",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Sansation",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0057FF),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    primary: Colors.white,
                                    elevation: 4,
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  size.width / 3, 10, 10, 10),
                              alignment: Alignment.topRight,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Harian.routeName);
                                },
                                icon: Icon(
                                  Icons.calendar_today_outlined,
                                  color: Color(0xFF0057FF),
                                ),
                                label: Text(""),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  primary: Colors.white,
                                  elevation: 4,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
