part of 'pages.dart';

class Harian extends StatefulWidget {
  static const String routeName = "/harian";

  @override
  _HarianState createState() => _HarianState();
}

class _HarianState extends State<Harian> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  DateTime focusedDay = DateTime.now();
  // var _calendarFormat;
  String dateToday = ActivityServices.dateToday();
  String dateNow = ActivityServices.dateNow();
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference asupanCollection =
      FirebaseFirestore.instance.collection("asupan");
  CollectionReference riwayatCollection =
      FirebaseFirestore.instance.collection("riwayat");
  bool isLoading;
  String asupanAkhir;

  _fetchriwayat() async {
    String documentName = formatter.format(focusedDay) + uid;
    if (uid != null) {
      await FirebaseFirestore.instance
          .collection('riwayat')
          .doc(documentName)
          .get()
          .then((ds) {
        asupanAkhir = ds.data()['asupanAkhir'].toString();
        print("$asupanAkhir");
        if ("$asupanAkhir" == null) {
          asupanAkhir = "0";
        }
      });
    }
  }

  // _fetchriwayat() {
  //   String documentName = formatter.format(focusedDay) + uid;
  //   if (uid != null) {
  //     FirebaseFirestore.instance
  //         .collection('riwayat')
  //         .where('riwayatid', isEqualTo: documentName)
  //         .snapshots();
  //   }
  // }

  Widget buildBody() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 1.45,
      child: StreamBuilder<QuerySnapshot>(
        stream: asupanCollection
            .where('addBy', isEqualTo: uid)
            .where('dateToday', isEqualTo: formatter.format(focusedDay))
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Failed to load data");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return ActivityServices.loadings();
          }

          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot doc) {
              Asupans asupans = new Asupans(
                doc.data()['asupanid'],
                doc.data()['jumlah'],
                doc.data()['addBy'],
                doc.data()['dateToday'],
                doc.data()['createdAt'],
                doc.data()['updatedAt'],
              );
              return AsupanCard(asupans: asupans);
            }).toList(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2230, 12, 31),
                  focusedDay: focusedDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarFormat: format,
                  onFormatChanged: (_format) {
                    setState(() {
                      format = _format;
                    });
                  },
                  daysOfWeekVisible: true,
                  onDaySelected: (DateTime selectDay, DateTime focusDay) {
                    setState(() {
                      selectedDay = selectDay;
                      focusedDay = focusDay;
                    });
                    print(formatter.format(focusedDay));
                  },
                  calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      todayDecoration: BoxDecoration(
                        color: Colors.blue[900],
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                          color: Colors.blueAccent[700],
                          shape: BoxShape.circle),
                      selectedTextStyle: TextStyle(color: Colors.white)),
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(selectedDay, date);
                  },
                  headerStyle: HeaderStyle(
                    titleTextStyle:
                        TextStyle(fontFamily: "Sansation", fontSize: 20),
                    formatButtonTextStyle: TextStyle(fontFamily: "Sansation"),
                  ),
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
                ),
              ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.25,
                minChildSize: 0.25,
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
                        Container(
                            margin: EdgeInsets.fromLTRB(15, 15, 0, 5),
                            child: FutureBuilder(
                                future: _fetchriwayat(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (!snapshot.hasError) {
                                    return Text(
                                      "Anda telah minum sebesar $asupanAkhir ml",
                                      style: TextStyle(
                                        fontFamily: 'Sansation',
                                        fontSize: 20,
                                        color: Color(0xFF0057FF),
                                      ),
                                    );
                                  } else {
                                    return Text(
                                      "Tidak ada Data",
                                      style: TextStyle(
                                        fontFamily: 'Sansation',
                                        fontSize: 20,
                                        color: Color(0xFF0057FF),
                                      ),
                                    );
                                  }
                                })),
                        buildBody(),
                        isLoading == true
                            ? ActivityServices.loadings()
                            : Container()
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
