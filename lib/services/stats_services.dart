part of 'services.dart';

class StatsServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  //setup cloud firestore
  static CollectionReference productCollection =
      FirebaseFirestore.instance.collection("stats");
  static DocumentReference statsDocument;

  //setup storage
  static Reference ref;
  static UploadTask uploadTask;
  static String imgUrl;

  static Future<bool> addJenisKelamin(Stats stats) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    statsDocument = await productCollection.add({
      'statsId': stats.userid,
      'addBy': auth.currentUser.uid,
      'jenisKelamin': stats.jenisKelamin,
      'berat': stats.berat,
      'tinggi': stats.tinggi,
      'usia': stats.usia,
      'asupan': stats.asupan,
      'waktuBangun': stats.waktuBangun,
      'waktuTidur': stats.waktuTidur,
      'fotoPengguna': stats.foto,
      'createdAt': dateNow,
      'updatedAt': dateNow
    });
  }

  static Future<bool> addDataTubuh(Stats stats) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();

    await productCollection.doc(statsDocument.id).update({
      'statsId': statsDocument.id,
      'berat': stats.berat,
      'tinggi': stats.tinggi,
      'usia': stats.usia,
      'updatedAt': dateNow
    });
  }

  static Future<bool> AddWaktuBangun(Stats stats) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();

    await productCollection.doc(statsDocument.id).update({
      'waktuBangun': stats.waktuBangun,
      'updatedAt': dateNow,
    });
  }

  static Future<bool> AddWaktuTidur(Stats stats) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();

    await productCollection.doc(statsDocument.id).update({
      'waktuTidur': stats.waktuTidur,
      'updatedAt': dateNow,
    });
  }

  static Future<bool> addImage(Stats stats, PickedFile imgFile) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    if (statsDocument != null) {
      ref = FirebaseStorage.instance
          .ref()
          .child("userImg")
          .child(statsDocument.id + ".jpg");
      uploadTask = ref.putFile(File(imgFile.path));

      await uploadTask.whenComplete(() => ref.getDownloadURL().then(
            (value) => imgUrl = value,
          ));

      productCollection.doc(statsDocument.id).update({
        'fotoPengguna': imgUrl,
        'updatedAt': dateNow,
      });

      return true;
    } else {
      return false;
    }
  }

  static Future getDataList() async {
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection('stats')
        .doc(statsDocument.id)
        .get();
    String jk = ds.get("jenisKelamin");
    String usia = ds.get("usia");
    String berat = ds.get("berat");
    String tinggi = ds.get("tinggi");
    String waktuBangun = ds.get("waktuBangun");
    String tidur = ds.get("waktuTidur");
    print(jk);
    return [jk, usia, berat, tinggi, waktuBangun, tidur];
  }
}
