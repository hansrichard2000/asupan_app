part of 'models.dart';

class Stats extends Equatable {
  final String userid;
  final String addby;
  final String jenisKelamin;
  final String berat;
  final String tinggi;
  final String usia;
  final String asupan;
  final String waktuBangun;
  final String waktuTidur;
  final String foto;
  final String createdAt;
  final String updatedAt;

  Stats(
    this.userid,
    this.addby,
    this.jenisKelamin,
    this.berat,
    this.tinggi,
    this.usia,
    this.asupan,
    this.waktuBangun,
    this.waktuTidur,
    this.foto,
    this.createdAt,
    this.updatedAt,
  );

  @override
  // TODO: implement props
  List<Object> get props => [
        userid,
        addby,
        jenisKelamin,
        berat,
        tinggi,
        usia,
        asupan,
        waktuBangun,
        waktuTidur,
        foto,
        createdAt,
        updatedAt,
      ];
}
