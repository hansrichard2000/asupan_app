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
    await productCollection.doc(auth.currentUser.uid).set({
      'statsId': auth.currentUser.uid,
      'jenisKelamin': stats.jenisKelamin,
      'berat': stats.berat,
      'tinggi': stats.tinggi,
      'usia': stats.usia,
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

    await productCollection.doc(auth.currentUser.uid).update({
      'berat': stats.berat,
      'tinggi': stats.tinggi,
      'usia': stats.usia,
      'asupanSementara': stats.asupanSementara,
      'asupanMinimum': stats.asupanMinimum,
      'updatedAt': dateNow
    });
  }

  static Future<bool> AddWaktuBangun(Stats stats) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();

    await productCollection.doc(auth.currentUser.uid).update({
      'waktuBangun': stats.waktuBangun,
      'updatedAt': dateNow,
    });
  }

  static Future<bool> AddWaktuTidur(Stats stats) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();

    await productCollection.doc(auth.currentUser.uid).update({
      'waktuTidur': stats.waktuTidur,
      'updatedAt': dateNow,
    });
  }

  static Future<bool> addImage(PickedFile imgFile) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    ref = FirebaseStorage.instance
        .ref()
        .child("userImg")
        .child(auth.currentUser.uid + ".jpg");
    uploadTask = ref.putFile(File(imgFile.path));

    await uploadTask.whenComplete(() => ref.getDownloadURL().then(
          (value) => imgUrl = value,
        ));

    productCollection.doc(auth.currentUser.uid).update({
      'fotoPengguna': imgUrl,
      'updatedAt': dateNow,
    });

    return true;
  }

  static Future getDataList() async {
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection('stats')
        .doc(auth.currentUser.uid)
        .get();
    String jk = ds.get("jenisKelamin");
    int usia = ds.get("usia");
    int berat = ds.get("berat");
    int tinggi = ds.get("tinggi");
    String waktuBangun = ds.get("waktuBangun");
    String tidur = ds.get("waktuTidur");
    return [jk, usia, berat, tinggi, waktuBangun, tidur];
  }
}
