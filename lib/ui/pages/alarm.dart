part of 'pages.dart';

class Alarm extends StatefulWidget {
  static const String routeName = "/alarm";
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  int _counter = 0;
  String name;
  String test = "22:16";
  String timeNow = ActivityServices.timeToday();
  TimeOfDay time;
  TimeOfDay picked;
  String waktuAlarm;
  bool isLoading;
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference alarmCollection =
      FirebaseFirestore.instance.collection("alarm");

  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              color: Colors.blueAccent[700],
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body),
                    ],
                  ),
                ),
              );
            });
      }
    });
  }

  showNotification() async {
    final pengguna = await FirebaseAuth.instance.currentUser.uid;
    if (pengguna != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(pengguna)
          .get()
          .then((ds) {
        name = ds.data()['name'];
        print(name);
      });
    }
    flutterLocalNotificationsPlugin.show(
        0,
        "Hai $name",
        "Saatnya minum air",
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  Widget buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: alarmCollection
            .where('addBy', isEqualTo: uid)
            .orderBy('clock', descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Failed to load data!");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return ActivityServices.loadings();
          }

          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot doc) {
              Alarms alarms = new Alarms(
                doc.data()['alarmId'],
                doc.data()['clock'],
                doc.data()['addBy'],
                doc.data()['isOn'],
                doc.data()['createdAt'],
                doc.data()['updatedAt'],
              );
              print(alarms.clock);
              if (alarms.clock == timeNow && alarms.isOn == true) {
                showNotification();
              }
              return AlarmList(
                alarms: alarms,
              );
            }).toList(),
          );
        },
      ),
    );
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
    print(waktu);
    return waktu;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(
            "Alarm",
            style: TextStyle(
              fontFamily: "Sansation",
              fontSize: 30,
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
                child: buildBody(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  onPressed: () async {
                    // showNotification();
                    setState(() {
                      isLoading = true;
                    });
                    waktuAlarm = await selectTime(context);
                    print(waktuAlarm);
                    Alarms alarms = Alarms(
                      "",
                      waktuAlarm,
                      "",
                      true,
                      "",
                      "",
                    );
                    String msg = await AlarmServices.addAlarm(alarms);
                    print(msg);
                    if (msg == "success") {
                      setState(() {
                        isLoading = false;
                      });
                      // Navigator.of(context).pop();
                      ActivityServices.showToast(
                          "Waktu berhasil disimpan", Colors.blueAccent[700]);
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                      // Navigator.of(context).pop();
                      ActivityServices.showToast(
                          "Waktu berhasil disimpan", Colors.blueAccent[700]);
                    }
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Color(0xFF0057FF),
                ),
              ),
              isLoading == true ? ActivityServices.loadings() : Container()
            ],
          ),
        ));
  }
}
