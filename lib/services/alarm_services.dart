part of 'services.dart';

class AlarmServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  //setup cloud firestore
  static CollectionReference alarmCollection =
      FirebaseFirestore.instance.collection("alarm");
  static DocumentReference alarmDocument;

  static Future<bool> addAlarm(Alarms alarms) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    alarmDocument = await alarmCollection.add({
      "alarmId": alarms.alarmId,
      "clock": alarms.clock,
      "addBy": auth.currentUser.uid,
      "isOn": alarms.isOn,
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
