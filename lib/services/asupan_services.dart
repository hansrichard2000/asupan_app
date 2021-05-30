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
    asupanDocument = await asupanCollection.add({
      "asupanid": asupans.asupanid,
      "jumlah": asupans.jumlah,
      "addBy": auth.currentUser.uid,
      "dateToday": dateToday,
      "createdAt": dateNow,
      "updatedAt": dateNow,
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
    await riwayatCollection.doc(dateToday + auth.currentUser.uid).set({
      "riwayatid": dateToday + auth.currentUser.uid,
      "asupanAkhir": riwayats.asupanAkhir,
      "addBy": auth.currentUser.uid,
      "dateToday": dateToday,
      "createdAt": dateNow,
      "updatedAt": dateNow,
    });
  }

  static Future<bool> editRiwayat(Riwayats riwayats) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String dateToday = ActivityServices.dateToday();
    await riwayatCollection.doc(dateToday + auth.currentUser.uid).update({
      "asupanAkhir": riwayats.asupanAkhir,
      "updatedAt": dateNow,
    });
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
