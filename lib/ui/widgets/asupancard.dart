part of 'widgets.dart';

class AsupanCard extends StatefulWidget {
  final Asupans asupans;

  const AsupanCard({this.asupans});

  @override
  _AsupanCardState createState() => _AsupanCardState();
}

class _AsupanCardState extends State<AsupanCard> {
  int jumlah;
  bool isLoading;
  TextEditingController ctrlAsupan;
  TimeOfDay time;
  TimeOfDay picked;
  String waktuAsupan;

  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();
  }

  Future<String> selectTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: time);
    String waktu = "${time.hour}:${time.minute}";
    if (picked != null) {
      setState(() {
        time = picked;
        waktu = "${time.hour}:${time.minute}";
      });
    }

    return waktu;
  }

  @override
  Widget build(BuildContext context) {
    Asupans asupans = widget.asupans;
    if (asupans == null) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          "No data",
          style: TextStyle(color: Colors.grey),
        ),
      );
    } else {
      return GestureDetector(
        onLongPress: () {
          showModalBottomSheet(
              // transitionAnimationController: AnimationController(vsync: vsync),
              context: context,
              builder: (BuildContext ctx) {
                return Container(
                  padding: EdgeInsets.all(32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton.icon(
                        icon: Icon(CupertinoIcons.pencil),
                        label: Text("Edit Data"),
                        onPressed: () async {
                          Asupans asupanku = widget.asupans;
                          await FirebaseFirestore.instance
                              .collection('asupan')
                              .doc(asupanku.asupanid)
                              .get()
                              .then((ds) {
                            jumlah = ds.data()['jumlah'];
                          });
                          ctrlAsupan =
                              new TextEditingController(text: "$jumlah");
                          showAsupanDialog(ctx);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent[700]),
                      ),
                      ElevatedButton.icon(
                        icon: Icon(CupertinoIcons.trash_fill),
                        label: Text("Delete Data"),
                        onPressed: () async {
                          int asupanLagi;
                          int currentdrink;
                          await FirebaseFirestore.instance
                              .collection('stats')
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .get()
                              .then((ds) {
                            asupanLagi = ds.data()['asupanSementara'];
                          });
                          await FirebaseFirestore.instance
                              .collection('asupan')
                              .doc(asupans.asupanid)
                              .get()
                              .then((ds) {
                            currentdrink = ds.data()['jumlah'];
                          });
                          int hasil = asupanLagi - currentdrink;
                          print(hasil);
                          Stats stats = Stats(
                            "",
                            "",
                            0,
                            0,
                            0,
                            0,
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
                          await StatsServices.decStats(stats);
                          await AsupanServices.editRiwayat(riwayats);
                          bool result = await AsupanServices.deleteAsupan(
                              asupans.asupanid);
                          if (result) {
                            // ActivityServices.loadings();
                            ActivityServices.showToast(
                                "Delete data success!", Colors.green);
                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                            ActivityServices.showToast(
                                "Delete data failed!", Colors.red);
                          }
                          Navigator.pushReplacementNamed(
                            context,
                            MainMenu.routeName,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        child: Card(
          elevation: 1,
          margin: EdgeInsets.all(8),
          child: Container(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: Icon(Icons.local_drink),
              title: Text(
                asupans.updatedAt,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                maxLines: 1,
                softWrap: true,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    asupans.jumlah.toString() + " ml",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  void showAsupanDialog(BuildContext ctx) async {
    Asupans asupans = widget.asupans;
    showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Edit Asupan"),
            content: Column(
              children: [
                TextFormField(
                  controller: ctrlAsupan,
                  decoration: InputDecoration(
                      labelText: "Asupan Anda",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () async {
                            waktuAsupan = await selectTime(context);
                            print(waktuAsupan);
                            // await FirebaseFirestore.instance
                            //     .collection("asupan")
                            //     .doc(asupans.asupanid)
                            //     .get()
                            //     .then((ds) {

                            //     });
                            Asupans asupanku =
                                Asupans("", 0, "", "", "", waktuAsupan);
                            await AsupanServices.editWaktuAsupan(
                                asupanku, asupans.asupanid);
                          },
                          icon: Icon(Icons.alarm),
                          iconSize: 22,
                        ),
                      ],
                    ),
                    Text(
                      "${time.hour}:${time.minute}",
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                )
              ],
            ),
            actions: [
              ElevatedButton.icon(
                onPressed: () async {
                  Asupans asupanku = widget.asupans;
                  int asupanLagi;
                  int currentdrink;
                  int hasilSebelum;
                  String minum;
                  await FirebaseFirestore.instance
                      .collection('asupan')
                      .doc(asupanku.asupanid)
                      .get()
                      .then((ds) {
                    jumlah = ds.data()['jumlah'];
                  });

                  print(asupanku.asupanid);
                  await FirebaseFirestore.instance
                      .collection('stats')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .get()
                      .then((ds) {
                    asupanLagi = ds.data()['asupanSementara'];
                    minum = ds.data()['minum'].toString();
                    currentdrink = int.parse(ctrlAsupan.text);
                  });
                  hasilSebelum = asupanLagi - jumlah;
                  int hasil = hasilSebelum + currentdrink;
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
                  String msg = await AsupanServices.editAsupan(
                      asupans, asupanku.asupanid);
                  if (msg == "success") {
                    Navigator.of(context).pop();
                    ActivityServices.showToast(
                        "Asupan berhasil di edit", Color(0xFF0057FF));
                  } else {
                    Navigator.pop(context);
                    ActivityServices.showToast(
                        "Asupan gagal di edit", Colors.red);
                  }
                  Navigator.pop(context);
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
