part of 'widgets.dart';

class AsupanCard extends StatefulWidget {
  final Asupans asupans;

  const AsupanCard({this.asupans});

  @override
  _AsupanCardState createState() => _AsupanCardState();
}

class _AsupanCardState extends State<AsupanCard> {
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent[700]),
                      ),
                      ElevatedButton.icon(
                        icon: Icon(CupertinoIcons.trash_fill),
                        label: Text("Delete Data"),
                        onPressed: () async {
                          // Asupans asupans = Asupans(
                          //   "",
                          //   _currentdrink,
                          //   FirebaseAuth.instance.currentUser.uid,
                          //   "",
                          //   "",
                          //   "",
                          // );
                          // int asupanLagi;
                          // await FirebaseFirestore.instance
                          //     .collection('stats')
                          //     .doc(FirebaseAuth.instance.currentUser.uid)
                          //     .get()
                          //     .then((ds) {
                          //   asupanLagi = ds.data()['asupanSementara'];
                          //   _currentIndex = ds.data()['minum'];
                          // });
                          // int hasil = asupanLagi + _currentdrink;
                          // print(hasil);
                          // Stats stats = Stats(
                          //   "",
                          //   "",
                          //   0,
                          //   0,
                          //   0,
                          //   _currentdrink,
                          //   hasil,
                          //   0,
                          //   "",
                          //   "",
                          //   "",
                          //   "",
                          //   "",
                          //   "",
                          // );
                          // Riwayats riwayats = Riwayats(
                          //   "",
                          //   hasil,
                          //   "",
                          //   "",
                          //   "",
                          //   "",
                          // );
                          // await StatsServices.updateStats(stats);
                          // await AsupanServices.editRiwayat(riwayats);
                          // await AsupanServices.addAsupan(asupans);
                          bool result = await AsupanServices.deleteAsupan(
                              asupans.asupanid);
                          if (result) {
                            ActivityServices.showToast(
                                "Delete data success!", Colors.green);
                          } else {
                            ActivityServices.showToast(
                                "Delete data failed!", Colors.red);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                      )
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
                asupans.createdAt,
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
}
