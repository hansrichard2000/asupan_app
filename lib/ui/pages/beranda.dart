part of 'pages.dart';

class Beranda extends StatefulWidget {
  static const String routeName = "/beranda";
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  // int _currentIndex = 0;

  int currentdrink;
  final ctrlAsupan = TextEditingController();
  // dynamic name = AuthServices.getUsersName();
  final log = Logger();
  bool isLoading = false;
  Color drinkButton1 = Colors.white;
  Color drinkButton2 = Colors.white;
  Color drinkButton3 = Colors.white;
  Color drinkButton4 = Colors.white;
  Color drinkButton5 = Colors.white;
  Color drinkButton6 = Colors.white;
  Color drinkButton7 = Colors.white;
  Color textButton1 = Color(0xFF0057FF);
  Color textButton2 = Color(0xFF0057FF);
  Color textButton3 = Color(0xFF0057FF);
  Color textButton4 = Color(0xFF0057FF);
  Color textButton5 = Color(0xFF0057FF);
  Color textButton6 = Color(0xFF0057FF);
  Color textButton7 = Color(0xFF0057FF);
  // final user = Provider.of<Users>(context);
  // final uid = user.uid;
  String namePengguna;
  String minum;
  String asupanSementara;
  String asupanMinimum;
  String tanggalSekarang;
  String dateToday = ActivityServices.dateToday();
  String dateTodayIndo = ActivityServices.dateTodayIndo();
  String dateNow = ActivityServices.dateNow();
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference asupanCollection =
      FirebaseFirestore.instance.collection("asupan");

  Widget buildBody() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 1.45,
      child: StreamBuilder<QuerySnapshot>(
        stream: asupanCollection
            .where('addBy', isEqualTo: uid)
            .where('dateToday', isEqualTo: dateToday)
            .orderBy('updatedAt', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(
                margin: EdgeInsets.only(left: 20),
                child: Text("Failed to load data"));
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
    // log.d(name.toString());
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder(
              future: _fetch(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text("Halo, $namePengguna");
              },
            ),
            Text(dateTodayIndo),
          ],
        ),
        elevation: 0,
        // backgroundColor: Colors.transparent,
      ),
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
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 3.5,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.7,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://www.toptal.com/designers/subtlepatterns/patterns/memphis-mini.png"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 35),
                          child: FutureBuilder(
                            future: _fetchasupan(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              try {
                                double progress =
                                    (double.parse("$asupanSementara") /
                                        double.parse("$asupanMinimum"));
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return ActivityServices.loadings();
                                } else {
                                  return CustomProgressBar(
                                      size.width / 1.9, progress * 100, 100);
                                }
                              } catch (e) {
                                return ActivityServices.loadings();
                              }
                            },
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: FutureBuilder(
                            future: _fetchasupan(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              return Text(
                                "$asupanSementara / $asupanMinimum ml",
                                style: TextStyle(
                                    fontFamily: 'Sansation',
                                    fontSize: 30,
                                    color: Color(0xFF0057FF)),
                              );
                            },
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 100),
                        alignment: Alignment.center,
                        child: Text(
                          "Target Minuman Harian",
                          style: TextStyle(
                              fontFamily: 'Sansation',
                              fontSize: 20,
                              color: Color(0xFF0057FF)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 30, size.height / 8.5),
              alignment: Alignment.centerRight,
              child: ClipOval(
                child: Material(
                  color: Colors.white, // button color
                  child: InkWell(
                    onTap: () async {
                      showDrinkDialog(context);
                    },
                    splashColor: Colors.blue[700], // inkwell color
                    child: SizedBox(
                        width: size.width / 9,
                        height: size.height / 15,
                        child: Icon(
                          Icons.local_drink,
                          color: Color(0xFF0057FF),
                        )),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: size.height / 4.9),
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    int asupanLagi;
                    await FirebaseFirestore.instance
                        .collection('stats')
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .get()
                        .then((ds) {
                      asupanLagi = ds.data()['asupanSementara'];
                      currentdrink = ds.data()['minum'];
                    });
                    Asupans asupans = Asupans(
                      "",
                      currentdrink,
                      FirebaseAuth.instance.currentUser.uid,
                      "",
                      "",
                      "",
                    );
                    int hasil = asupanLagi + currentdrink;
                    print(hasil);
                    Stats stats = Stats(
                      "",
                      "",
                      0,
                      0,
                      0,
                      currentdrink,
                      hasil,
                      0,
                      "",
                      "",
                      "",
                      "",
                      "",
                      "",
                    );
                    Riwayats riwayats = Riwayats(
                      "",
                      hasil,
                      "",
                      "",
                      "",
                      "",
                    );
                    await StatsServices.updateStats(stats);
                    await AsupanServices.editRiwayat(riwayats);
                    await AsupanServices.addAsupan(asupans).then((value) {
                      if (value == true) {
                        ActivityServices.showToast(
                            "Catatan berhasil ditambahkan", Color(0xFF0057FF));
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        ActivityServices.showToast(
                            "Catatan gagal ditambahkan", Colors.red);
                        setState(() {
                          isLoading = false;
                        });
                      }
                    });
                  },
                  child: FutureBuilder(
                    future: _fetchasupan(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Text("+ $minum ml",
                          style: TextStyle(
                            fontFamily: "Sansation",
                            fontSize: 20,
                          ));
                    },
                  ),
                  style: ElevatedButton.styleFrom(primary: Color(0xFF0057FF))),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.5,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Catatan minum hari ini:",
                                style: TextStyle(
                                  fontFamily: 'Sansation',
                                  fontSize: 20,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    showAsupanDialog(context);
                                  },
                                  icon: Icon(Icons.add))
                            ],
                          ),
                        ),
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

  void showDrinkDialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return Center(
              child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width / 1.7,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            drinkButton1 = Colors.blueAccent[700];
                            drinkButton2 = Colors.white;
                            drinkButton3 = Colors.white;
                            drinkButton4 = Colors.white;
                            drinkButton5 = Colors.white;
                            drinkButton6 = Colors.white;
                            drinkButton7 = Colors.white;
                            textButton1 = Colors.white;
                            textButton2 = Color(0xFF0057FF);
                            textButton3 = Color(0xFF0057FF);
                            textButton4 = Color(0xFF0057FF);
                            textButton5 = Color(0xFF0057FF);
                            textButton6 = Color(0xFF0057FF);
                            textButton7 = Color(0xFF0057FF);
                            currentdrink = 100;
                          });
                          Stats stats = Stats(
                            "",
                            "",
                            0,
                            0,
                            0,
                            currentdrink,
                            0,
                            0,
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                          );
                          await StatsServices.updateMinum(stats);
                        },
                        child: Text(
                          "100",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Sansation",
                            color: textButton1,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            primary: drinkButton1,
                            elevation: 4,
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5)),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            drinkButton1 = Colors.white;
                            drinkButton2 = Colors.blueAccent[700];
                            drinkButton3 = Colors.white;
                            drinkButton4 = Colors.white;
                            drinkButton5 = Colors.white;
                            drinkButton6 = Colors.white;
                            drinkButton7 = Colors.white;
                            textButton1 = Color(0xFF0057FF);
                            textButton2 = Colors.white;
                            textButton3 = Color(0xFF0057FF);
                            textButton4 = Color(0xFF0057FF);
                            textButton5 = Color(0xFF0057FF);
                            textButton6 = Color(0xFF0057FF);
                            textButton7 = Color(0xFF0057FF);
                            currentdrink = 125;
                          });
                          Stats stats = Stats(
                            "",
                            "",
                            0,
                            0,
                            0,
                            currentdrink,
                            0,
                            0,
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                          );
                          await StatsServices.updateMinum(stats);
                        },
                        child: Text(
                          "125",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Sansation",
                            color: textButton2,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            primary: drinkButton2,
                            elevation: 4,
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5)),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            drinkButton1 = Colors.white;
                            drinkButton2 = Colors.white;
                            drinkButton3 = Colors.blueAccent[700];
                            drinkButton4 = Colors.white;
                            drinkButton5 = Colors.white;
                            drinkButton6 = Colors.white;
                            drinkButton7 = Colors.white;
                            textButton1 = Color(0xFF0057FF);
                            textButton2 = Color(0xFF0057FF);
                            textButton3 = Colors.white;
                            textButton4 = Color(0xFF0057FF);
                            textButton5 = Color(0xFF0057FF);
                            textButton6 = Color(0xFF0057FF);
                            textButton7 = Color(0xFF0057FF);
                            currentdrink = 150;
                          });
                          Stats stats = Stats(
                            "",
                            "",
                            0,
                            0,
                            0,
                            currentdrink,
                            0,
                            0,
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                          );
                          await StatsServices.updateMinum(stats);
                        },
                        child: Text(
                          "150",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Sansation",
                            color: textButton3,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            primary: drinkButton3,
                            elevation: 4,
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            drinkButton1 = Colors.white;
                            drinkButton2 = Colors.white;
                            drinkButton3 = Colors.white;
                            drinkButton4 = Colors.blueAccent[700];
                            drinkButton5 = Colors.white;
                            drinkButton6 = Colors.white;
                            drinkButton7 = Colors.white;
                            textButton1 = Color(0xFF0057FF);
                            textButton2 = Color(0xFF0057FF);
                            textButton3 = Color(0xFF0057FF);
                            textButton4 = Colors.white;
                            textButton5 = Color(0xFF0057FF);
                            textButton6 = Color(0xFF0057FF);
                            textButton7 = Color(0xFF0057FF);
                            currentdrink = 175;
                          });
                          Stats stats = Stats(
                            "",
                            "",
                            0,
                            0,
                            0,
                            currentdrink,
                            0,
                            0,
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                          );
                          await StatsServices.updateMinum(stats);
                        },
                        child: Text(
                          "175",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Sansation",
                            color: textButton4,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            primary: drinkButton4,
                            elevation: 4,
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5)),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            drinkButton1 = Colors.white;
                            drinkButton2 = Colors.white;
                            drinkButton3 = Colors.white;
                            drinkButton4 = Colors.white;
                            drinkButton5 = Colors.blueAccent[700];
                            drinkButton6 = Colors.white;
                            drinkButton7 = Colors.white;
                            textButton1 = Color(0xFF0057FF);
                            textButton2 = Color(0xFF0057FF);
                            textButton3 = Color(0xFF0057FF);
                            textButton4 = Color(0xFF0057FF);
                            textButton5 = Colors.white;
                            textButton6 = Color(0xFF0057FF);
                            textButton7 = Color(0xFF0057FF);
                            currentdrink = 200;
                          });
                          Stats stats = Stats(
                            "",
                            "",
                            0,
                            0,
                            0,
                            currentdrink,
                            0,
                            0,
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                          );
                          await StatsServices.updateMinum(stats);
                        },
                        child: Text(
                          "200",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Sansation",
                            color: textButton5,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            primary: drinkButton5,
                            elevation: 4,
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5)),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            drinkButton1 = Colors.white;
                            drinkButton2 = Colors.white;
                            drinkButton3 = Colors.white;
                            drinkButton4 = Colors.white;
                            drinkButton5 = Colors.white;
                            drinkButton6 = Colors.blueAccent[700];
                            drinkButton7 = Colors.white;
                            textButton1 = Color(0xFF0057FF);
                            textButton2 = Color(0xFF0057FF);
                            textButton3 = Color(0xFF0057FF);
                            textButton4 = Color(0xFF0057FF);
                            textButton5 = Color(0xFF0057FF);
                            textButton6 = Colors.white;
                            textButton7 = Color(0xFF0057FF);
                            currentdrink = 300;
                          });
                          Stats stats = Stats(
                            "",
                            "",
                            0,
                            0,
                            0,
                            currentdrink,
                            0,
                            0,
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                          );
                          await StatsServices.updateMinum(stats);
                        },
                        child: Text(
                          "300",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Sansation",
                            color: textButton6,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            primary: drinkButton6,
                            elevation: 4,
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            drinkButton1 = Colors.white;
                            drinkButton2 = Colors.white;
                            drinkButton3 = Colors.white;
                            drinkButton4 = Colors.white;
                            drinkButton5 = Colors.white;
                            drinkButton6 = Colors.white;
                            drinkButton7 = Colors.blueAccent[700];
                            textButton1 = Color(0xFF0057FF);
                            textButton2 = Color(0xFF0057FF);
                            textButton3 = Color(0xFF0057FF);
                            textButton4 = Color(0xFF0057FF);
                            textButton5 = Color(0xFF0057FF);
                            textButton6 = Color(0xFF0057FF);
                            textButton7 = Colors.white;
                            currentdrink = 400;
                          });
                          Stats stats = Stats(
                            "",
                            "",
                            0,
                            0,
                            0,
                            currentdrink,
                            0,
                            0,
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                          );
                          await StatsServices.updateMinum(stats);
                        },
                        child: Text(
                          "400",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Sansation",
                            color: textButton7,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            primary: drinkButton7,
                            elevation: 4,
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ));
        });
  }

  _fetch() async {
    final pengguna = await FirebaseAuth.instance.currentUser.uid;
    if (pengguna != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(pengguna)
          .get()
          .then((ds) {
        namePengguna = ds.data()['name'];
        print(namePengguna);
      });
    }
  }

  _fetchasupan() async {
    final pengguna = await FirebaseAuth.instance.currentUser.uid;
    if (pengguna != null) {
      await FirebaseFirestore.instance
          .collection('stats')
          .doc(pengguna)
          .get()
          .then((ds) {
        minum = ds.data()['minum'].toString();
        asupanSementara = ds.data()['asupanSementara'].toString();
        asupanMinimum = ds.data()['asupanMinimum'].toString();
        tanggalSekarang = ds.data()['dateUpdated'].toString();
        print("$tanggalSekarang");
        print("Hari ini" + dateToday);
      });
      if ("$tanggalSekarang" != dateToday) {
        Stats stats = Stats(
          "",
          "",
          0,
          0,
          0,
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
        Riwayats riwayats = Riwayats(
          "",
          0,
          "",
          "",
          "",
          "",
        );
        await StatsServices.resetStats(stats);
        await AsupanServices.addRiwayat(riwayats);
      }
    }
  }

  void showAsupanDialog(BuildContext ctx) async {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Tambah Asupan Manual"),
            content: TextFormField(
              controller: ctrlAsupan,
              decoration: InputDecoration(
                  labelText: "Asupan Anda",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),
            actions: [
              ElevatedButton.icon(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  int asupanLagi;
                  await FirebaseFirestore.instance
                      .collection('stats')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .get()
                      .then((ds) {
                    asupanLagi = ds.data()['asupanSementara'];
                    minum = ds.data()['minum'].toString();
                    currentdrink = int.parse(ctrlAsupan.text);
                  });
                  int hasil = asupanLagi + currentdrink;
                  print(hasil);
                  Asupans asupans = Asupans(
                    "",
                    currentdrink,
                    FirebaseAuth.instance.currentUser.uid,
                    "",
                    "",
                    "",
                  );
                  currentdrink = int.parse("$minum");
                  Stats stats = Stats(
                    "",
                    "",
                    0,
                    0,
                    0,
                    currentdrink,
                    hasil,
                    0,
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                  );
                  Riwayats riwayats = Riwayats(
                    "",
                    hasil,
                    "",
                    "",
                    "",
                    "",
                  );
                  await StatsServices.updateStats(stats);
                  await AsupanServices.editRiwayat(riwayats);
                  await AsupanServices.addAsupan(asupans).then((value) {
                    if (value == true) {
                      ActivityServices.showToast(
                          "Catatan berhasil ditambahkan", Color(0xFF0057FF));
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      ActivityServices.showToast(
                          "Catatan gagal ditambahkan", Colors.red);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  });

                  Navigator.pushReplacementNamed(context, MainMenu.routeName);
                },
                icon: Icon(Icons.save),
                label: Text("Save"),
                style: ElevatedButton.styleFrom(elevation: 0),
              )
            ],
          );
        });
  }
}
