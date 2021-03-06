part of 'pages.dart';

class Databerat extends StatefulWidget {
  static const String routeName = "/databerat";
  @override
  _DataberatState createState() => _DataberatState();
}

class _DataberatState extends State<Databerat> {
  final _formKey = GlobalKey<FormState>();
  final ctrlBerat = TextEditingController();
  final ctrlTinggi = TextEditingController();
  final ctrlUsia = TextEditingController();
  double hasil;
  bool isVisible = true;
  bool isLoading = false;
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
                    height: 20,
                  ),
                  Container(
                      child: Text("Data Tubuh Anda",
                          style: TextStyle(fontSize: 24, color: Colors.white))),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(32),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: ctrlBerat,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Berat Anda (kg)",
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2))),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Wajib diisi";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            controller: ctrlTinggi,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Tinggi Anda (cm)",
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2))),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Wajib diisi";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            controller: ctrlUsia,
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Usia Anda",
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2))),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Wajib diisi";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          String jk;
                          await FirebaseFirestore.instance
                              .collection('stats')
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .get()
                              .then((ds) {
                            jk = ds.data()['jenisKelamin'];
                          });
                          if ("$jk" == "Laki-laki") {
                            print("$jk");
                            hasil = (2.447 -
                                    ((0.09145 * double.parse(ctrlUsia.text)) +
                                        (0.1074 *
                                            double.parse(ctrlTinggi.text)) +
                                        (0.3362 *
                                            double.parse(ctrlBerat.text)))) /
                                -2;
                          } else if ("$jk" == "Perempuan") {
                            hasil = (-2.097 +
                                    ((0.1069 * double.parse(ctrlTinggi.text)) +
                                        (0.2466 *
                                            double.parse(ctrlBerat.text)))) /
                                2;
                          }
                          Stats stats = Stats(
                            "",
                            "",
                            int.parse(ctrlBerat.text),
                            int.parse(ctrlTinggi.text),
                            int.parse(ctrlUsia.text),
                            175,
                            0,
                            hasil.toInt() * 100,
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                          );
                          await StatsServices.addDataTubuh(stats).then(
                              (value) => ActivityServices.showToast(
                                  "Berhasil Disimpan", Colors.green));
                          isLoading = false;
                          Navigator.pushReplacementNamed(
                              context, Bangun.routeName);
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          Fluttertoast.showToast(
                              msg: "Isian masih ada yang kosong",
                              backgroundColor: Colors.red);
                        }
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
                    height: 20,
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
                                    context, Datajk.routeName);
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
                                    context, Bangun.routeName);
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
