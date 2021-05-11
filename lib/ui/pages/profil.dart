part of 'pages.dart';

class Profil extends StatefulWidget {
  static const String routeName = "/profil";
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  bool isLoading = false;
  String namaPengguna;
  String emailPengguna;
  String jk;
  var titleList = [
    "Jenis Kelamin",
    "Usia",
    "Berat Badan",
    "Tinggi",
    "Waktu Bangun",
    "Waktu Tidur",
    "Satuan",
    "Tujuan Asupan",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final log = Logger();
    // log.d(dataPengguna[0]);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        toolbarHeight: 0,
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
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 37),
                  alignment: Alignment.topCenter,
                  child: ClipOval(
                    child: Material(
                      color: Colors.white,
                      child: InkWell(
                        splashColor: Colors.blueAccent[700],
                        onTap: () {},
                        child: SizedBox(
                          width: size.width / 4.5,
                          height: size.height / 7.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.topCenter,
                  child: FutureBuilder(
                    future: _fetchnama(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Text(
                        "$namaPengguna",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Sansation",
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.topCenter,
                  child: FutureBuilder(
                    future: _fetchemail(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Text(
                        "$emailPengguna",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Sansation",
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.65,
                minChildSize: 0.65,
                maxChildSize: 1,
                builder: (BuildContext c, s) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        // horizontal: 15,
                        // vertical: 0,
                        ),
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
                      shrinkWrap: true,
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
                          margin: EdgeInsets.fromLTRB(20, 10, 0, 20),
                          child: Text(
                            "Data Pribadi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 1.5,
                          child: ListView.builder(
                              itemCount: titleList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    elevation: 0,
                                    color: Color(0xFFf1fcff),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                titleList[index],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: "Sansation"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: FutureBuilder(
                                            future: fetchdata(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              return Text("halo");
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await AuthServices.signOut().then((value) {
                    if (value == true) {
                      setState(() {
                        isLoading = false;
                      });
                      ActivityServices.showToast(
                          "Berhasil Keluar", Colors.blueAccent[700]);
                      Navigator.pushReplacementNamed(context, Login.routeName);
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                      ActivityServices.showToast("Gagal Keluar", Colors.red);
                    }
                  });
                },
                icon: Icon(Icons.login_rounded),
                label: Text("Logout"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  elevation: 0,
                ),
              ),
            ),
            isLoading == true ? ActivityServices.loadings() : Container()
          ],
        ),
      ),
    );
  }

  _fetchnama() async {
    final pengguna = await FirebaseAuth.instance.currentUser.uid;
    if (pengguna != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(pengguna)
          .get()
          .then((ds) {
        namaPengguna = ds.data()['name'];
        print(namaPengguna);
      });
    }
  }

  _fetchemail() async {
    final pengguna = await FirebaseAuth.instance.currentUser.uid;
    if (pengguna != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(pengguna)
          .get()
          .then((ds) {
        emailPengguna = ds.data()['email'];
        print(emailPengguna);
      });
    }
  }

  fetchdata() async {
    dynamic dataPengguna = await StatsServices.getDataList();
    if (dataPengguna != null) {
      setState(() {
        jk = dataPengguna[0];
        print("$jk");
      });
    }
  }
}
