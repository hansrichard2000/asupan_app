part of 'services.dart';

class AsupanServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  //setup cloud firestore
  static CollectionReference asupanCollection =
      FirebaseFirestore.instance.collection("asupan");
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
}
