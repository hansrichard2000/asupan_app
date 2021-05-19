part of 'services.dart';

class AsupanServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  //setup cloud firestore
  static CollectionReference asupanCollection =
      FirebaseFirestore.instance.collection("asupan");
  static DocumentReference asupanDocument;

  static Future<bool> addAsupan(Asupan asupan) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    asupanDocument = await asupanCollection.add({
      "asupanid": asupan.asupanid,
      "jumlah": asupan.jumlah,
      "addBy": auth.currentUser.uid,
      "createdAt": dateNow,
      "updatedAt": dateNow,
    });
    if (asupanDocument != null) {
      asupanCollection.doc(asupanDocument.id).update({
        'asupanid': asupanDocument.id,
      });
    }
  }
}
