part of 'services.dart';

class AsupanServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  //setup cloud firestore
  static CollectionReference asupanCollection =
      FirebaseFirestore.instance.collection("asupan");
  static CollectionReference riwayatCollection =
      FirebaseFirestore.instance.collection("riwayat");
  static DocumentReference asupanDocument;

  static Future<bool> addAsupan(Asupans asupans) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String dateToday = ActivityServices.dateToday();
    String timeToday = ActivityServices.timeToday();
    asupanDocument = await asupanCollection.add({
      "asupanid": asupans.asupanid,
      "jumlah": asupans.jumlah,
      "addBy": auth.currentUser.uid,
      "dateToday": dateToday,
      "createdAt": timeToday,
      "updatedAt": timeToday,
    });
    if (asupanDocument != null) {
      asupanCollection.doc(asupanDocument.id).update({
        'asupanid': asupanDocument.id,
      });
    }

    return true;
  }

  static Future<bool> addRiwayat(Riwayats riwayats) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String dateToday = ActivityServices.dateToday();
    String timeToday = ActivityServices.timeToday();
    await riwayatCollection.doc(dateToday + auth.currentUser.uid).set({
      "riwayatid": dateToday + auth.currentUser.uid,
      "asupanAkhir": riwayats.asupanAkhir,
      "addBy": auth.currentUser.uid,
      "dateToday": dateToday,
      "createdAt": timeToday,
      "updatedAt": timeToday,
    });
  }

  static Future<bool> editRiwayat(Riwayats riwayats) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String dateToday = ActivityServices.dateToday();
    String timeToday = ActivityServices.timeToday();
    await riwayatCollection.doc(dateToday + auth.currentUser.uid).update({
      "asupanAkhir": riwayats.asupanAkhir,
      "updatedAt": timeToday,
    });
  }

  static Future<String> editAsupan(Asupans asupans, String id) async {
    String msg;
    String dateNow = ActivityServices.dateNow();
    String timeToday = ActivityServices.timeToday();
    await Firebase.initializeApp();
    await asupanCollection.doc(id).update({
      "jumlah": asupans.jumlah,
    }).then((value) {
      msg = "success";
    }).catchError((onError) {
      msg = onError;
    });

    return msg;
  }

  static Future<String> editWaktuAsupan(Asupans asupans, String id) async {
    String msg;
    await Firebase.initializeApp();
    await asupanCollection.doc(id).update({
      "updatedAt": asupans.updatedAt,
    }).then((value) {
      msg = "success";
    }).catchError((onError) {
      msg = onError;
    });

    return msg;
  }

  static Future<bool> deleteAsupan(String id) async {
    bool hsl = true;
    await Firebase.initializeApp();
    await asupanCollection.doc(id).delete().then((value) {
      hsl = true;
    }).catchError((onError) {
      hsl = false;
    });

    return hsl;
  }
}
