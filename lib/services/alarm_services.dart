part of 'services.dart';

class AlarmServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  //setup cloud firestore
  static CollectionReference alarmCollection =
      FirebaseFirestore.instance.collection("alarm");
  static DocumentReference alarmDocument;

  static Future<String> addAlarm(Alarms alarms) async {
    await Firebase.initializeApp();
    String msg;
    String dateNow = ActivityServices.dateNow();
    alarmDocument = await alarmCollection.add({
      "alarmId": alarms.alarmId,
      "clock": alarms.clock,
      "addBy": auth.currentUser.uid,
      "isOn": alarms.isOn,
      "createdAt": dateNow,
      "updatedAt": dateNow,
    });
    alarmCollection.doc(alarmDocument.id).update({
      'alarmId': alarmDocument.id,
    }).then((value) {
      msg = "success";
    }).catchError((onError) {
      msg = onError;
    });
    return msg;
  }

  static Future<String> ubahWaktu(Alarms alarms, String id) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String msg;

    await alarmCollection.doc(id).update({
      'clock': alarms.clock,
      'updatedAt': dateNow,
    }).then((value) {
      msg = "success";
    }).catchError((onError) {
      msg = onError;
    });

    return msg;
  }

  static Future<bool> ubahStatus(Alarms alarms, String id) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();

    await alarmCollection.doc(id).update({
      'isOn': alarms.isOn,
      'updatedAt': dateNow,
    });

    return true;
  }

  static Future<bool> deleteAlarm(String id) async {
    bool hsl = true;
    await Firebase.initializeApp();
    await alarmCollection.doc(id).delete().then((value) {
      hsl = true;
    }).catchError((onError) {
      hsl = false;
    });

    return hsl;
  }
}
