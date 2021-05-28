part of 'pages.dart';

class UpdateProfil extends StatefulWidget {
  static const String routeName = "/updateprofil";
  @override
  _UpdateProfilState createState() => _UpdateProfilState();
}

class _UpdateProfilState extends State<UpdateProfil> {
  final _formKey = GlobalKey<FormState>();
  final ctrlJK = TextEditingController();
  final ctrlBerat = TextEditingController();
  final ctrlTinggi = TextEditingController();
  final ctrlUsia = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(
            "Ubah Data Diri",
            style: TextStyle(
              fontFamily: "Sansation",
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          elevation: 0,
        ),
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
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xFFf1fcff),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  onPressed: () async {},
                  child: Icon(Icons.add),
                  backgroundColor: Color(0xFF0057FF),
                ),
              ),
            ],
          ),
        ));
  }
}
