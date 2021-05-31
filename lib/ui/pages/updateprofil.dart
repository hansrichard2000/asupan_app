part of 'pages.dart';

class UpdateProfil extends StatefulWidget {
  static const String routeName = "/updateprofil";
  @override
  _UpdateProfilState createState() => _UpdateProfilState();
}

enum Gender { Lakilaki, Perempuan }

class _UpdateProfilState extends State<UpdateProfil> {
  Gender _gender = Gender.Lakilaki;
  final _formKey = GlobalKey<FormState>();
  // String ctrlJK;

  String jk;
  double hasil;
  bool isVisible = true;
  bool isLoading = false;
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    print(data);
    final size = MediaQuery.of(context).size;
    TextEditingController ctrlBerat =
        new TextEditingController(text: data['berat']);
    TextEditingController ctrlTinggi =
        new TextEditingController(text: data['tinggi']);
    TextEditingController ctrlUsia =
        new TextEditingController(text: data['usia']);
    // final ctrlBerat = TextEditingController();
    // final ctrlTinggi = TextEditingController();
    // final ctrlUsia = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(
            "Ubah Data Diri",
            style: TextStyle(
              fontFamily: "Sansation",
              fontSize: 24,
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
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                width: double.infinity,
                height: double.infinity,
                child: ListView(
                  children: <Widget>[
                    // Container(
                    //   width: double.infinity,
                    //   height: double.infinity,
                    //   padding: EdgeInsets.all(32),
                    Form(
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.all(32),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              SizedBox(
                                height: 24,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Jenis Kelamin Anda : ",
                                  style: TextStyle(
                                    color: Color(0xFF0057FF),
                                    fontFamily: "Sansation",
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Radio<Gender>(
                                    value: Gender.Lakilaki,
                                    groupValue: _gender,
                                    onChanged: (Gender value) {
                                      setState(() {
                                        _gender = Gender.Lakilaki;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Laki-laki",
                                    style: TextStyle(
                                      color: Color(0xFF0057FF),
                                      fontFamily: "Sansation",
                                      fontSize: 20,
                                    ),
                                  ),
                                  Radio<Gender>(
                                    value: Gender.Perempuan,
                                    groupValue: _gender,
                                    onChanged: (Gender value) {
                                      setState(() {
                                        _gender = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Perempuan",
                                    style: TextStyle(
                                      color: Color(0xFF0057FF),
                                      fontFamily: "Sansation",
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              // TextFormField(
                              //   controller: ctrlJK,
                              //   keyboardType: TextInputType.emailAddress,
                              //   decoration: InputDecoration(
                              //       labelText: "Jenis Kelamin",
                              //       border: OutlineInputBorder(
                              //           borderSide:
                              //               BorderSide(color: Colors.blue))),
                              //   autovalidateMode:
                              //       AutovalidateMode.onUserInteraction,
                              //   validator: (value) {
                              //     return value.isEmpty ? "Wajib diisi" : null;
                              //   },
                              // ),
                              SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                controller: ctrlUsia,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    labelText: "Usia",
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue))),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value.isEmpty ? "Wajib diisi" : null;
                                },
                              ),
                              SizedBox(height: 24),
                              TextFormField(
                                controller: ctrlBerat,
                                decoration: InputDecoration(
                                  labelText: "Berat Anda",
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value.isEmpty ? "Wajib diisi" : null;
                                },
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                controller: ctrlTinggi,
                                decoration: InputDecoration(
                                  labelText: "Tinggi Anda",
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value.isEmpty ? "Wajib diisi" : null;
                                },
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    print(_gender);
                                    if (_gender == Gender.Lakilaki) {
                                      setState(() {
                                        jk = "Laki-laki";
                                      });
                                      hasil = (2.447 -
                                              ((0.09145 *
                                                      double.parse(
                                                          ctrlUsia.text)) +
                                                  (0.1074 *
                                                      double.parse(
                                                          ctrlTinggi.text)) +
                                                  (0.3362 *
                                                      double.parse(
                                                          ctrlBerat.text)))) /
                                          -2;
                                      print(hasil);
                                    } else if (_gender == Gender.Perempuan) {
                                      jk = "Perempuan";
                                      hasil = (-2.097 +
                                              ((0.1069 *
                                                      double.parse(
                                                          ctrlTinggi.text)) +
                                                  (0.2466 *
                                                      double.parse(
                                                          ctrlBerat.text)))) /
                                          2;
                                      print(hasil);
                                      print(jk);
                                    }
                                    Stats stats = Stats(
                                      "",
                                      jk,
                                      int.parse(ctrlBerat.text),
                                      int.parse(ctrlTinggi.text),
                                      int.parse(ctrlUsia.text),
                                      0,
                                      0,
                                      hasil.toInt() * 100,
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                    );
                                    await StatsServices.EditDataTubuh(stats)
                                        .then((value) =>
                                            ActivityServices.showToast(
                                                "Berhasil Disimpan",
                                                Colors.green));
                                    isLoading = false;
                                    Navigator.pushReplacementNamed(
                                      context,
                                      MainMenu.routeName,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Masih ada data yang kosong!");
                                  }
                                },
                                child: Text(
                                  "Simpan",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Sansation",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    primary: Colors.blueAccent[700],
                                    elevation: 4,
                                    padding: EdgeInsets.fromLTRB(70, 5, 70, 5)),
                              ),
                              SizedBox(height: 24),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              isLoading == true ? ActivityServices.loadings() : Container(),
            ],
          ),
        ));
  }

  String berat;
  String tinggi;
  String usia;
  String jenisK;

  _fetchdata() async {
    final pengguna = await FirebaseAuth.instance.currentUser.uid;
    if (pengguna != null) {
      await FirebaseFirestore.instance
          .collection('stats')
          .doc(pengguna)
          .get()
          .then((ds) {
        berat = ds.data()['berat'].toString();
        tinggi = ds.data()['tinggi'].toString();
        usia = ds.data()['usia'].toString();
      });
    }
  }
}
