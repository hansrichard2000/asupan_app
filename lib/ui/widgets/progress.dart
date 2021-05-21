part of 'widgets.dart';

class CustomProgressBar extends StatelessWidget {
  final double width;
  final double value;
  final double totalValue;

  CustomProgressBar(this.width, this.value, this.totalValue);

  @override
  Widget build(BuildContext context) {
    double ratio = value / totalValue;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.timer,
          color: Colors.grey[700],
        ),
        SizedBox(width: 5),
        Stack(
          children: <Widget>[
            Container(
              width: width,
              height: 10,
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(5)),
            ),
            Material(
              borderRadius: BorderRadius.circular(5),
              child: AnimatedContainer(
                height: 10,
                width: width * ratio,
                duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(
                    color: (ratio < 0.3)
                        ? Colors.blueAccent
                        : (ratio < 0.6)
                            ? Colors.blueAccent[700]
                            : Color(0xFF0057FF),
                    borderRadius: BorderRadius.circular(5)),
              ),
            )
          ],
        ),
      ],
    );
  }
}
