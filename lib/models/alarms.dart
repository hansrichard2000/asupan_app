part of 'models.dart';

class Alarms extends Equatable {
  final String alarmId;
  final String clock;
  final String addBy;
  final bool isOn;
  final String createdAt;
  final String updatedAt;

  Alarms(this.alarmId, this.clock, this.addBy, this.isOn, this.createdAt,
      this.updatedAt);

  @override
  // TODO: implement props
  List<Object> get props => [
        alarmId,
        clock,
        addBy,
        isOn,
        createdAt,
        updatedAt,
      ];
}
