part of 'widgets.dart';

class TimePicker extends StatefulWidget {
  const TimePicker();
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    dateTime = getDateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildTimePicker(),
          const SizedBox(
            height: 24,
          ),
          // Container(
          //   margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          //   child: ElevatedButton(
          //     onPressed: () {

          //     },
          //     child: Text(
          //       "SIMPAN",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         fontFamily: "Sansation",
          //         fontSize: 20,
          //         fontWeight: FontWeight.w700,
          //         color: Color(0xFF0057FF),
          //       ),
          //     ),
          //     style: ElevatedButton.styleFrom(
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(12)),
          //         primary: Colors.white,
          //         elevation: 4,
          //         padding: EdgeInsets.fromLTRB(70, 5, 70, 5)),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildTimePicker() => SizedBox(
        height: 180,
        child: CupertinoTheme(
          data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyle(fontSize: 30)),
            brightness: Brightness.dark,
            primaryContrastingColor: Colors.white,
            barBackgroundColor: Colors.white,
          ),
          child: CupertinoDatePicker(
            initialDateTime: dateTime,
            mode: CupertinoDatePickerMode.time,
            minuteInterval: 10,
            //use24hFormat: true,
            onDateTimeChanged: (dateTime) =>
                setState(() => this.dateTime = dateTime),
          ),
        ),
      );

  DateTime getDateTime() {
    final now = DateTime.now();

    return DateTime(now.year, now.month, now.day, now.hour, 0);
  }
}
