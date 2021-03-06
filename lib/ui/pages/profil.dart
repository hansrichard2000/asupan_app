part of 'pages.dart';

class Profil extends StatefulWidget {
  static const String routeName = "/profil";
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference statsCollection =
      FirebaseFirestore.instance.collection("stats");
  final ctrlName = TextEditingController();
  bool isLoading = false;
  PickedFile imageFile;
  String namaPengguna;
  String emailPengguna;
  String fotoPengguna;
  String jk;
  String usia;
  String berat;
  String tinggi;
  String asupanMinimum;
  String waktuBangun, tidur;
  final ImagePicker imagePicker = ImagePicker();

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
                        onTap: () {
                          showFileDialog(context);
                        },
                        child: SizedBox(
                          child: Semantics(
                              child: Center(
                            child: FutureBuilder(
                              future: _fetchimage(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (fotoPengguna == null) {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.person, size: 56),
                                  );
                                } else {
                                  return Image.network(
                                    "$fotoPengguna",
                                    width: 100,
                                  );
                                }
                                // try {
                                //   return Image.network("$fotoPengguna");
                                // } catch (e) {
                                //   return Container(
                                //     alignment: Alignment.center,
                                //     child: Icon(Icons.person, size: 56),
                                //   );
                                // }
                              },
                            ),
                          )),
                          width: size.width / 4.5,
                          height: size.height / 7.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 10, 0, 0),
                      alignment: Alignment.topCenter,
                      child: FutureBuilder(
                        future: _fetchnama(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          showNameDialog(context);
                        },
                        icon: Icon(
                          CupertinoIcons.pencil,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "Data Pribadi",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, UpdateProfil.routeName,
                                          arguments: {
                                            'berat': '$berat',
                                            'tinggi': '$tinggi',
                                            'usia': '$usia',
                                          });
                                    },
                                    icon: Icon(CupertinoIcons.pencil),
                                    label: Text(
                                      "Edit",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Sansation"),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF0057FF),
                                      elevation: 2,
                                    ),
                                  ),
                                ),
                              ],
                            )),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              FutureBuilder(
                                                future: _fetchdata(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  var dataList = [
                                                    "$jk",
                                                    "$usia",
                                                    "$berat",
                                                    "$tinggi",
                                                    "$waktuBangun",
                                                    "$tidur",
                                                    "ml",
                                                    "$asupanMinimum ml",
                                                  ];
                                                  return Text(
                                                    dataList[index],
                                                    style: TextStyle(
                                                      color: Color(0xFF0057FF),
                                                      fontFamily: "Sansation",
                                                      fontSize: 16,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
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

  _fetchimage() async {
    final pengguna = await FirebaseAuth.instance.currentUser.uid;
    if (pengguna != null) {
      await FirebaseFirestore.instance
          .collection('stats')
          .doc(pengguna)
          .get()
          .then((ds) {
        fotoPengguna = ds.data()['fotoPengguna'];
      });
    }
  }

  _fetchdata() async {
    final pengguna = await FirebaseAuth.instance.currentUser.uid;
    if (pengguna != null) {
      await FirebaseFirestore.instance
          .collection('stats')
          .doc(pengguna)
          .get()
          .then((ds) {
        jk = ds.data()['jenisKelamin'];
        usia = ds.data()['usia'].toString();
        berat = ds.data()['berat'].toString();
        tinggi = ds.data()['tinggi'].toString();
        waktuBangun = ds.data()['waktuBangun'];
        tidur = ds.data()['waktuTidur'];
        asupanMinimum = ds.data()['asupanMinimum'].toString();
      });
    }
  }

  Future chooseFile(String type) async {
    ImageSource imgSrc;
    if (type == "camera") {
      imgSrc = ImageSource.camera;
    } else if (type == "gallery") {
      imgSrc = ImageSource.gallery;
    }
    final selectedImage = await imagePicker.getImage(
      source: imgSrc,
      imageQuality: 50,
    );
    setState(() {
      imageFile = selectedImage;
    });
  }

  // void showProfileDialog(BuildContext ctx, title) {
  //   showDialog(
  //       context: ctx,
  //       builder: (ctx) {
  //         return Center(
  //           child: Material(
  //             type: MaterialType.transparency,
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10),
  //                 color: Colors.white,
  //               ),
  //               padding: EdgeInsets.all(15),
  //               width: MediaQuery.of(context).size.width * 0.7,
  //               height: MediaQuery.of(context).size.height / 2,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: <Widget>[
  //                   Text(
  //                     title,
  //                     style: TextStyle(
  //                       fontFamily: "Sansation",
  //                       fontSize: 20,
  //                       color: Color(0xFF0057FF),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }
  void showNameDialog(BuildContext ctx) async {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Edit your name"),
            content: TextFormField(
              controller: ctrlName,
              decoration: InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value.isEmpty) {
                  return "Bagian ini wajib diisi";
                } else {
                  return value.length > 30 ? "Nama maksimum 30 karakter" : null;
                }
              },
            ),
            actions: [
              ElevatedButton.icon(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  Users users = new Users(
                    "",
                    ctrlName.text,
                    "",
                    "",
                    "",
                    "",
                    "",
                  );
                  await AuthServices.ubahNama(users).then((value) {
                    print(value);
                    if (value == "success") {
                      setState(() {
                        isLoading = false;
                      });
                      ActivityServices.showToast(
                          "Ubah nama berhasil", Colors.green);
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                      ActivityServices.showToast("Gagal ubah nama", Colors.red);
                    }
                  });
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.save),
                label: Text("Save"),
                style: ElevatedButton.styleFrom(elevation: 0),
              )
            ],
          );
        });
  }

  void showFileDialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Confirmation"),
            content: Text("Pick image from:"),
            actions: [
              ElevatedButton.icon(
                onPressed: () {
                  chooseFile("camera");
                  print(imageFile.path);
                },
                icon: Icon(Icons.camera_alt),
                label: Text("Camera"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  chooseFile("gallery");
                  print(imageFile.path);
                },
                icon: Icon(Icons.folder_outlined),
                label: Text("Gallery"),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await StatsServices.addImage(imageFile).then((value) {
                    if (value == true) {
                      ActivityServices.showToast(
                          "Ubah Foto Profil berhasil", Colors.green);
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                      ActivityServices.showToast(
                          "Gagal ubah foto profil", Colors.red);
                    }
                  });
                  Navigator.of(context).pop();
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
