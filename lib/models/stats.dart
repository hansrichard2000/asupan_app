part of 'models.dart';

class Stats extends Equatable {
  final String userid;
  final String jenisKelamin;
  final double berat;
  final double tinggi;
  final double usia;
  final int minum;
  final int asupanSementara;
  final int asupanMinimum;
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
    this.minum,
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
        minum,
        asupanSementara,
        asupanMinimum,
        waktuBangun,
        waktuTidur,
        foto,
        createdAt,
        updatedAt,
      ];
}
