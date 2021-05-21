part of 'models.dart';

class Asupans extends Equatable {
  final String asupanid;
  final int jumlah;
  final String addBy;
  final String createdAt;
  final String updatedAt;

  Asupans(
      this.asupanid, this.jumlah, this.addBy, this.createdAt, this.updatedAt);

  @override
  // TODO: implement props
  List<Object> get props => [
        asupanid,
        jumlah,
        addBy,
        createdAt,
        updatedAt,
      ];
}
