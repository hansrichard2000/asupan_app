part of 'widgets.dart';

class AlarmList extends StatefulWidget {
  final Alarms alarms;
  AlarmList({this.alarms});

  @override
  _AlarmListState createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    Alarms alarms = widget.alarms;
    if (alarms == null) {
      return Container();
    } else {
      return Container(
        margin: EdgeInsets.only(top: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Color(0xFFf1fcff),
          elevation: 0,
          margin: EdgeInsets.all(8),
          child: Container(
            padding: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                alarms.clock,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                maxLines: 1,
                softWrap: true,
              ),
              subtitle: Text(
                "Setiap Hari",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                maxLines: 1,
                softWrap: true,
              ),
              trailing: Container(
                child: Switch(
                  activeColor: Color(0xFF0057FF),
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[350],
                  value: isOn,
                  onChanged: (newValue) {
                    isOn = newValue;
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
