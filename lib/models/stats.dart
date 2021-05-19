part of 'models.dart';

class Stats extends Equatable {
  final String userid;
  final String jenisKelamin;
  final int berat;
  final int tinggi;
  final int usia;
  final int asupanSementara;
  final double asupanMinimum;
  final String waktuBangun;
  final String waktuTidur;
  final String foto;
  final String createdAt;
  final String updatedAt;

  Stats(
    this.userid,
    this.jenisKelamin,
    this.berat,
    this.tinggi,
    this.usia,
    this.asupanSementara,
    this.asupanMinimum,
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
        jenisKelamin,
        berat,
        tinggi,
        usia,
        asupanSementara,
        asupanMinimum,
        waktuBangun,
        waktuTidur,
        foto,
        createdAt,
        updatedAt,
      ];
}
