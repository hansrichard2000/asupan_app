part of 'models.dart';

class Riwayats extends Equatable {
  final String asupanid;
  final int asupanAkhir;
  final String addBy;
  final String createdAt;
  final String updatedAt;

  Riwayats(this.asupanid, this.asupanAkhir, this.addBy, this.createdAt,
      this.updatedAt);

  @override
  // TODO: implement props
  List<Object> get props => [
        asupanid,
        asupanAkhir,
        addBy,
        createdAt,
        updatedAt,
      ];
}
