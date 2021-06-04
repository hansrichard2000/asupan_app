part of 'widgets.dart';

class AlarmList extends StatefulWidget {
  final Alarms alarms;
  AlarmList({this.alarms});

  @override
  _AlarmListState createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  bool isOn = true;
  String clock;
  TextEditingController ctrlClock;
  TimeOfDay time;
  TimeOfDay picked;
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference alarmCollection =
      FirebaseFirestore.instance.collection("alarm");

  Future<String> selectTime(BuildContext context) async {
    Alarms alarms = widget.alarms;
    await alarmCollection.doc(alarms.alarmId).get().then((ds) {
      clock = ds.data()['clock'];
    });
    time = TimeOfDay(
        hour: int.parse(clock.split(":")[0]),
        minute: int.parse(clock.split(":")[1]));
    picked = await showTimePicker(context: context, initialTime: time);
    String waktu = "${time.hour}:${time.minute}";
    if (picked != null) {
      setState(() {
        time = picked;
        waktu = "${time.hour}:${time.minute}";
      });
    }
    print(waktu);
    return waktu;
  }

  @override
  Widget build(BuildContext context) {
    Alarms alarms = widget.alarms;
    if (alarms == null) {
      return Container();
    } else {
      return Container(
        margin: EdgeInsets.only(top: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Color(0xFFf1fcff),
          elevation: 0,
          margin: EdgeInsets.all(8),
          child: Container(
            padding: EdgeInsets.all(8),
            child: ListTile(
              title: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      // transitionAnimationController: AnimationController(vsync: vsync),
                      context: context,
                      builder: (BuildContext ctx) {
                        print(alarms.alarmId);
                        String id = alarms.alarmId;
                        return Container(
                          padding: EdgeInsets.all(32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ElevatedButton.icon(
                                icon: Icon(CupertinoIcons.pencil),
                                label: Text("Edit Data"),
                                onPressed: () async {
                                  String waktuAkhir;
                                  waktuAkhir = await selectTime(context);
                                  print(waktuAkhir);
                                  Alarms alarms = new Alarms(
                                      "", waktuAkhir, "", true, "", "");
                                  String msg =
                                      await AlarmServices.ubahWaktu(alarms, id);
                                  if (msg == "success") {
                                    ActivityServices.showToast(
                                        "Berhasil diubah",
                                        Colors.blueAccent[700]);
                                    Navigator.of(context).pop();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueAccent[700]),
                              ),
                              ElevatedButton.icon(
                                icon: Icon(CupertinoIcons.trash_fill),
                                label: Text("Delete Data"),
                                onPressed: () async {
                                  bool result = await AlarmServices.deleteAlarm(
                                      alarms.alarmId);
                                  if (result) {
                                    // ActivityServices.loadings();
                                    ActivityServices.showToast(
                                        "Delete data success!", Colors.green);
                                  } else {
                                    ActivityServices.showToast(
                                        "Delete data failed!", Colors.red);
                                  }
                                  Navigator.pop(context);
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
                child: Text(
                  alarms.clock,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  softWrap: true,
                ),
              ),
              subtitle: Text(
                "Setiap Hari",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                maxLines: 1,
                softWrap: true,
              ),
              trailing: Container(
                child: Switch(
                  activeColor: Color(0xFF0057FF),
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[350],
                  value: isOn,
                  onChanged: (newValue) {
                    isOn = newValue;
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
  // onTap: () {
  //                 showModalBottomSheet(
  //                     // transitionAnimationController: AnimationController(vsync: vsync),
  //                     context: context,
  //                     builder: (BuildContext ctx) {
  //                       return Container(
  //                         padding: EdgeInsets.all(32),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                           children: <Widget>[
  //                             ElevatedButton.icon(
  //                               icon: Icon(CupertinoIcons.pencil),
  //                               label: Text("Edit Data"),
  //                               onPressed: () async {
  //                                 waktuAkhir = await selectTime(context);
  //                                 Alarms alarms = new Alarms(
  //                                     "", waktuAkhir, "", true, "", "");
  //                                 String msg = await AlarmServices.ubahWaktu(
  //                                     alarms, alarms.alarmId);
  //                                 if (msg == "success") {
  //                                   ActivityServices.showToast(
  //                                       "Berhasil diubah",
  //                                       Colors.blueAccent[700]);
  //                                   Navigator.of(context).pop();
  //                                 }
  //                               },
  //                               style: ElevatedButton.styleFrom(
  //                                   primary: Colors.blueAccent[700]),
  //                             ),
  //                             ElevatedButton.icon(
  //                               icon: Icon(CupertinoIcons.trash_fill),
  //                               label: Text("Delete Data"),
  //                               onPressed: () async {
  //                                 bool result = await AlarmServices.deleteAlarm(
  //                                     alarms.alarmId);
  //                                 if (result) {
  //                                   // ActivityServices.loadings();
  //                                   ActivityServices.showToast(
  //                                       "Delete data success!", Colors.green);
  //                                   Navigator.pop(context);
  //                                 } else {
  //                                   Navigator.pop(context);
  //                                   ActivityServices.showToast(
  //                                       "Delete data failed!", Colors.red);
  //                                 }
  //                                 Navigator.of(context).pop();
  //                               },
  //                               style: ElevatedButton.styleFrom(
  //                                 primary: Colors.red,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       );
  //                     });
  //               },
}
