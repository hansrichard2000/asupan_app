part of 'pages.dart';

class Register extends StatefulWidget {
  static const String routeName = "/register";
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  final TextEditingController _ctrlConfirmPassword = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height - 200,
              color: Color(0xFF0057FF),
            ),
            Container(
              height: size.height / 4,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Color(0xFF0085FF), Color(0xFFFFFF)],
                      tileMode: TileMode.repeated)),
            ),
            WaveWidget(
                size: size, yOffset: size.height / 4, color: Colors.white),
            Container(
              margin: EdgeInsets.fromLTRB(30, size.height / 9, 0, 0),
              child: Text("Buat Akun",
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
              margin: EdgeInsets.fromLTRB(0, size.height / 5, 0, 0),
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
                              controller: ctrlName,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: "Nama",
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
                                  return value.length > 12
                                      ? "Nama maksimum 12 karakter"
                                      : null;
                                }
                              },
                            ),
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
                              controller: _ctrlPassword,
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
                                if (value.isEmpty) {
                                  return "Bagian ini wajib diisi";
                                } else {
                                  return value.length < 6
                                      ? "Sandi minimum 6 karakter!"
                                      : null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: _ctrlConfirmPassword,
                              obscureText: isVisible,
                              decoration: InputDecoration(
                                  labelText: "Konfirmasi Sandi",
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
                                if (value.isEmpty) {
                                  return "Bagian ini wajib diisi";
                                }
                                if (value != _ctrlPassword.text) {
                                  return "Sandi tidak cocok";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Users users = new Users(
                                      "",
                                      ctrlName.text,
                                      ctrlEmail.text,
                                      _ctrlPassword.text,
                                      _ctrlConfirmPassword.text,
                                      "",
                                      "");
                                  String msg = await AuthServices.signUp(users);
                                  if (msg == "success") {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ActivityServices.showToast(
                                        "Register Success",
                                        Colors.blueAccent[700]);
                                    Navigator.pushReplacementNamed(
                                        context, Login.routeName);
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Masih ada data yang kosong!");
                                }
                              },
                              child: Text(
                                "DAFTAR SEKARANG",
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
                            SizedBox(height: 24),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, Login.routeName);
                              },
                              child: Text(
                                "Sudah terdaftar? Masuk.",
                                style: TextStyle(
                                  color: Colors.blueAccent[700],
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                  // )
                ],
              ),
            ),
            isLoading == true ? ActivityServices.loadings() : Container()
          ],
        ),
      ),
    );
  }
}
