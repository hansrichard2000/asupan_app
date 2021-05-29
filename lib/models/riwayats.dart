part of 'models.dart';

class Riwayats extends Equatable {
  final String riwayatid;
  final int asupanAkhir;
  final String addBy;
  final String dateToday;
  final String createdAt;
  final String updatedAt;

  Riwayats(this.riwayatid, this.asupanAkhir, this.addBy, this.dateToday,
      this.createdAt, this.updatedAt);

  @override
  // TODO: implement props
  List<Object> get props => [
        riwayatid,
        asupanAkhir,
        addBy,
        dateToday,
        createdAt,
        updatedAt,
      ];
}
