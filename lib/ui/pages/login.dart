part of 'pages.dart';

class Login extends StatefulWidget {
  static const String routeName = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.amber,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // padding: EdgeInsets.all(32),
        // decoration: const BoxDecoration(color: Color(0xFF0057FF)),
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height - 200,
              color: Color(0xFF0057FF),
            ),
            Container(
              height: size.height / 2.5,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Color(0xFF0085FF), Color(0xFFFFFF)],
                      tileMode: TileMode.repeated)),
            ),
            WaveWidget(
                size: size, yOffset: size.height / 2.5, color: Colors.white),
            // Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            // children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(30, size.height / 9, 0, 0),
              child: Text("Selamat Datang",
                  style: TextStyle(
                    fontFamily: "Sansation",
                    fontSize: 36,
                    color: Colors.white,
                  )),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, size.height / 6, 0, 0),
              child: Image(
                image: AssetImage("assets/images/texture3.png"),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, size.height / 2.8, 0, 0),
              child: ListView(
                children: <Widget>[
                  // Container(
                  //   width: double.infinity,
                  //   height: double.infinity,
                  //   padding: EdgeInsets.all(32),
                  Form(
                      key: _formKey,
                      child: Container(
                        margin: EdgeInsets.all(32),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: ctrlEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  prefixIcon: Icon(Icons.mail_outline_rounded),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Bagian ini wajib diisi";
                                } else {
                                  if (!EmailValidator.validate(value)) {
                                    return "Email tidak valid";
                                  } else {
                                    return null;
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 24),
                            TextFormField(
                              controller: ctrlPassword,
                              obscureText: isVisible,
                              decoration: InputDecoration(
                                  labelText: "Sandi",
                                  prefixIcon: Icon(Icons.vpn_key),
                                  border: OutlineInputBorder(),
                                  suffixIcon: new GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    },
                                    child: Icon(isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  )),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                return value.length < 6
                                    ? "Sandi minimum 6 karakter!"
                                    : null;
                              },
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Lupa Sandi?",
                                style: TextStyle(color: Color(0xFF0057FF)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    String msg = await AuthServices.signIn(
                                        ctrlEmail.text, ctrlPassword.text);
                                    if (msg == "success") {
                                      Navigator.pushReplacementNamed(
                                          context, Beranda.routeName);
                                    } else if (msg != "success") {
                                      Fluttertoast.showToast(
                                          msg: "email atau password salah",
                                          backgroundColor: Colors.red);
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Tolong isi email dan password dulu!");
                                  }
                                },
                                child: Text(
                                  "MASUK",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Sansation",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    primary: Colors.blueAccent[700],
                                    elevation: 4,
                                    padding: EdgeInsets.fromLTRB(70, 5, 70, 5)),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, Register.routeName);
                              },
                              child: Text(
                                "DAFTAR",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Sansation",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  primary: Colors.blueAccent[700],
                                  elevation: 4,
                                  padding: EdgeInsets.fromLTRB(70, 5, 70, 5)),
                            ),
                          ],
                        ),
                      )),
                  // )
                ],
              ),
            ),
          ],
        ),
        // ],
      ),
      // ),
    );
  }
}
