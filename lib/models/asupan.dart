part of 'models.dart';

class Asupan extends Equatable {
  final String asupanid;
  final int jumlah;
  final String createdAt;
  final String updatedAt;

  Asupan(this.asupanid, this.jumlah, this.createdAt, this.updatedAt);

  @override
  // TODO: implement props
  List<Object> get props => [
        asupanid,
        jumlah,
        createdAt,
        updatedAt,
      ];
}