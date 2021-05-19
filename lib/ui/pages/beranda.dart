part of 'pages.dart';

class Beranda extends StatefulWidget {
  static const String routeName = "/beranda";
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  int _currentIndex = 0;
  // dynamic name = AuthServices.getUsersName();
  final log = Logger();
  // final user = Provider.of<Users>(context);
  // final uid = user.uid;
  String namePengguna;
  // FirebaseFirestore.instance.collection('users').doc('vqiLVKZ3z5Pab6RxDitlslJTUPZ2').get(FieldPath('name'));
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // log.d(name.toString());
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,

        title: FutureBuilder(
          future: _fetch(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Text("Halo, $namePengguna");
          },
        ),
        elevation: 0,
        // backgroundColor: Colors.transparent,
      ),
      backgroundColor: Color(0xFF0057FF),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xFFFFFF), Color(0xFF0085FF)],
                tileMode: TileMode.repeated)),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 3.5,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.7,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://www.toptal.com/designers/subtlepatterns/patterns/memphis-mini.png"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "1000 / 2030 ml",
                          style: TextStyle(
                              fontFamily: 'Sansation',
                              fontSize: 28,
                              color: Color(0xFF0057FF)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 35),
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Target Minuman Harian",
                          style: TextStyle(
                              fontFamily: 'Sansation',
                              fontSize: 20,
                              color: Color(0xFF0057FF)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.5,
                maxChildSize: 1,
                builder: (BuildContext c, s) {
                  return Container(
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: 15,
                    //   vertical: 10,
                    // ),
                    decoration: BoxDecoration(
                        color: Color(0xFFf1fcff),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent[700],
                            blurRadius: 10,
                          )
                        ]),
                    child: ListView(
                      controller: s,
                      children: <Widget>[
                        Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 15, 0, 5),
                          child: Text(
                            "Catatan minum hari ini:",
                            style: TextStyle(
                              fontFamily: 'Sansation',
                              fontSize: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                // margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                // width: double.infinity,
                // height: double.infinity,
                // decoration: const BoxDecoration(
                //     color: Color(0xFFf1fcff),
                //     borderRadius:
                //         BorderRadius.vertical(top: Radius.circular(20))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _fetch() async {
    final pengguna = await FirebaseAuth.instance.currentUser.uid;
    if (pengguna != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(pengguna)
          .get()
          .then((ds) {
        namePengguna = ds.data()['name'];
        print(namePengguna);
      });
    }
  }
}
