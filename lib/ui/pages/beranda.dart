part of 'pages.dart';

class Beranda extends StatefulWidget {
  static const String routeName = "/beranda";
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
              margin: EdgeInsets.fromLTRB(30, 60, 0, 0),
              child: Text("Halo",
                  style: TextStyle(
                    fontFamily: "Sansation",
                    fontSize: 30,
                    color: Colors.white,
                  )),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, size.height / 2, 0, 0),
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              child: ElevatedButton(
                child: Text("Logout"),
                onPressed: () {
                  AuthServices.signOut();
                  Navigator.pushReplacementNamed(context, Login.routeName);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Riwayat",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.alarm,
            ),
            label: "Alarm",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
