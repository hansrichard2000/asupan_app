part of 'pages.dart';

class Tidur extends StatefulWidget {
  static const String routeName = "/tidur";
  @override
  _TidurState createState() => _TidurState();
}

class _TidurState extends State<Tidur> {
  DateTime dateTime = DateTime.now();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    dateTime = getDateTime();
  }

  DateTime getDateTime() {
    final now = DateTime.now();

    return DateTime(now.year, now.month, now.day, now.hour, 0);
  }

  Widget buildTimePicker() => SizedBox(
        height: 180,
        child: CupertinoTheme(
          data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyle(fontSize: 30)),
            brightness: Brightness.dark,
            primaryContrastingColor: Colors.white,
            barBackgroundColor: Colors.white,
          ),
          child: CupertinoDatePicker(
            initialDateTime: dateTime,
            mode: CupertinoDatePickerMode.time,
            minuteInterval: 10,
            //use24hFormat: true,
            onDateTimeChanged: (dateTime) =>
                setState(() => this.dateTime = dateTime),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonSize = size.width / 5;
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
                              color: Color(0xFF0057FF),
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
                      child: Text("Waktu Tidur Anda",
                          style: TextStyle(fontSize: 36, color: Colors.white))),
                  SizedBox(
                    height: 35,
                  ),
                  buildTimePicker(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        final tidur = DateFormat('HH:mm').format(dateTime);
                        Stats stats = Stats(
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          tidur,
                          "",
                          "",
                          "",
                        );
                        await StatsServices.AddWaktuTidur(stats).then((value) =>
                            ActivityServices.showToast(tidur, Colors.green));
                        Navigator.pushReplacementNamed(
                            context, MainMenu.routeName);
                      },
                      child: Text(
                        "SIMPAN",
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
                  SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ClipOval(
                          child: Material(
                            color: Colors.white, // button color
                            child: InkWell(
                              child: SizedBox(
                                  width: size.width / 5,
                                  height: size.height / 8.5,
                                  child: Icon(
                                    Icons.arrow_left,
                                    size: buttonSize,
                                  )),
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, Bangun.routeName);
                              },
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
                                    context, Login.routeName);
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
