part of 'pages.dart';

class Harian extends StatefulWidget {
  static const String routeName = "/harian";
  @override
  _HarianState createState() => _HarianState();
}

class _HarianState extends State<Harian> {
  var _selectedDay;
  var _focusedDay;
  var _calendarFormat;
  String dateNow = ActivityServices.dateNow();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          "Detail Minum Harian",
          style: TextStyle(
            fontFamily: "Sansation",
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
              decoration: BoxDecoration(),
              child: Card(
                margin: EdgeInsets.all(8),
                child: TableCalendar(
                  firstDay: DateTime.utc(2000, 10, 16),
                  lastDay: DateTime.utc(2230, 3, 14),
                  focusedDay: DateTime.now(),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay =
                          focusedDay; // update `_focusedDay` here as well
                    });
                  },
                  weekendDays: [6, 7],
                  // headerStyle: HeaderStyle(decoration: BoxDecoration(color: Colors.blue[200])),
                  calendarBuilders: CalendarBuilders(
                    dowBuilder: (context, day) {
                      final text = DateFormat.E().format(day);
                      return Center(
                        child: Text(
                          text,
                          style: TextStyle(color: Color(0xFF0057FF)),
                        ),
                      );
                    },
                  ),
                  // calendarFormat: _calendarFormat,
                  // onFormatChanged: (format) {
                  //   setState(() {
                  //     _calendarFormat = format;
                  //   });
                  // },
                  // onPageChanged: (focusedDay) {
                  //   _focusedDay = focusedDay;
                  // },
                  // eventLoader: (day) {
                  //   return _getEventsForDay(day);
                  // },
                ),
              ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.4,
                minChildSize: 0.4,
                maxChildSize: 1,
                builder: (BuildContext c, s) {
                  return Container(
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: 15,
                    //   vertical: 10,
                    // ),
                    decoration: BoxDecoration(
                        color: Color(0xFFf1fcff),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent[700],
                            blurRadius: 10,
                          )
                        ]),
                    child: ListView(
                      controller: s,
                      children: <Widget>[
                        Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                // margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                // width: double.infinity,
                // height: double.infinity,
                // decoration: const BoxDecoration(
                //     color: Color(0xFFf1fcff),
                //     borderRadius:
                //         BorderRadius.vertical(top: Radius.circular(20))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
