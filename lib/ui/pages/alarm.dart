part of 'pages.dart';

class Alarm extends StatefulWidget {
  static const String routeName = "/alarm";
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(
            "Alarm",
            style: TextStyle(
              fontFamily: "Sansation",
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          elevation: 0,
        ),
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
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xFFf1fcff),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
              ),
            ],
          ),
        ));
  }
}
