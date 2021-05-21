part of 'widgets.dart';

class AsupanCard extends StatefulWidget {
  final Asupans asupans;

  const AsupanCard({this.asupans});

  @override
  _AsupanCardState createState() => _AsupanCardState();
}

class _AsupanCardState extends State<AsupanCard> {
  @override
  Widget build(BuildContext context) {
    Asupans asupans = widget.asupans;
    if (asupans == null) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          "No data",
          style: TextStyle(color: Colors.grey),
        ),
      );
    } else {
      return Card(
        elevation: 1,
        margin: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: Icon(Icons.local_drink),
            title: Text(
              asupans.createdAt,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              maxLines: 1,
              softWrap: true,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  asupans.jumlah.toString() + " ml",
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
