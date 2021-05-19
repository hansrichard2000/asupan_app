part of 'services.dart';

class AlarmServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  //setup cloud firestore
  static CollectionReference alarmCollection =
      FirebaseFirestore.instance.collection("alarm");
  static DocumentReference alarmDocument;

  static Future<bool> addAlarm(Alarm alarm) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    alarmDocument = await alarmCollection.add({
      "alarmId": alarm.alarmId,
      "clock": alarm.clock,
      "addBy": auth.currentUser.uid,
      "isOn": alarm.isOn,
      "createdAt": dateNow,
      "updatedAt": dateNow,
    });
    if (alarmDocument != null) {
      alarmCollection.doc(alarmDocument.id).update({
        'asupanid': alarmDocument.id,
      });
    }
  }
}
